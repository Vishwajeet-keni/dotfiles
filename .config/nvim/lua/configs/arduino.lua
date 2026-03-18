local M = {}

local boards = {
  ["Arduino Uno"]   = "arduino:avr:uno",
  ["Arduino Nano"]  = "arduino:avr:nano",
  ["Arduino Mega"]  = "arduino:avr:mega",
  ["NodeMCU 1.0"]   = "esp8266:esp8266:nodemcuv2",
  ["Teensy 4.0"]    = "teensy:avr:teensy40",
  ["Teensy 4.1"]    = "teensy:avr:teensy41",
}

local state_file = "/tmp/eww_arduino_state"

function M.get_state()
  local f = io.open(state_file, "r")
  if not f then return nil, nil end
  local board, port = f:read("*l"), f:read("*l")
  f:close()
  return board, port
end

function M.save_state(board, port)
  local f = io.open(state_file, "w")
  if f then f:write(board .. "\n" .. port); f:close() end
end

function M.select_board()
  local items = vim.tbl_keys(boards)
  table.sort(items)
  vim.ui.select(items, { prompt = "Select board:" }, function(choice)
    if not choice then return end
    local _, port = M.get_state()
    M.save_state(boards[choice], port or "")
    vim.notify("Board set: " .. choice, vim.log.levels.INFO)
  end)
end

function M.select_port()
  local result = vim.fn.systemlist("arduino-cli board list | awk 'NR>1 && $1!=\"\" {print $1}'")
  if #result == 0 then
    vim.notify("No ports found", vim.log.levels.WARN)
    return
  end
  vim.ui.select(result, { prompt = "Select port:" }, function(choice)
    if not choice then return end
    local board, _ = M.get_state()
    M.save_state(board or "", choice)
    vim.notify("Port set: " .. choice, vim.log.levels.INFO)
  end)
end

function M.upload()
  local board, port = M.get_state()
  if not board or board == "" then
    vim.notify("No board selected — press <leader>ub first", vim.log.levels.WARN)
    return
  end
  if not port or port == "" then
    vim.notify("No port selected — press <leader>up first", vim.log.levels.WARN)
    return
  end
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.expand("%:p:h")
  vim.cmd("w")
  local cmd = string.format(
    "arduino-cli compile --fqbn %s %s && arduino-cli upload -p %s --fqbn %s %s",
    board, dir, port, board, dir
  )
  vim.cmd("botright split | resize 12 | term " .. cmd)
  vim.notify("Compiling and uploading...", vim.log.levels.INFO)
end

return M
