defmodule Ex5 do
  def getOpcode(number) do
    splitNum= Integer.digits(number)
    firstNumber= append(Enum.count(splitNum), splitNum)
    if(Enum.at(firstNumber, 3)== 0) do
      opCode= Enum.at(firstNumber,4)
    else
      opCode= String.to_integer(Integer.to_string(Enum.at(firstNumber, 3)) <> "" <> Integer.to_string(Enum.at(firstNumber, 4)))
    end
  end

  def getMode(number, paramNumber) do
    splitNum= Integer.digits(number)
    firstNumber= append(Enum.count(splitNum), splitNum)
    # for which parameter we need the opcode
    cond do
      paramNumber === 1 -> Enum.at(firstNumber, 2)
      paramNumber === 2 -> Enum.at(firstNumber, 1)
      paramNumber === 3 -> Enum.at(firstNumber, 0)
    end
  end

  def getValue(param, mode, inputArray) do
    if mode == 0 do
      Enum.at(inputArray, param)
    else
      param
    end
  end

  def processInput(param1, param2, param3, opcode, param1Mode, param2Mode, param3Mode, inputArray) do
    cond do
      opcode==99 ->
        inputArray
      opcode==1 ->
        value1 = getValue(param1, param1Mode, inputArray)
        value2 = getValue(param2, param2Mode, inputArray)
        List.replace_at(inputArray, param3, value1 + value2)
      opcode==2 ->
        value1 = getValue(param1, param1Mode, inputArray)
        value2 = getValue(param2, param2Mode, inputArray)
        List.replace_at(inputArray, param3, value1 * value2)
      opcode==3 ->
        value = readInput
        List.replace_at(inputArray, param1, value)
      opcode==4 ->
        value = getValue(param1, param1Mode, inputArray)
        IO.puts "print mode is #{param1Mode} value #{value} param1 #{param1}"
        IO.puts value
        inputArray
    end
  end

  def readInput  do
    tempInput = IO.gets("enter number" )
    input = String.to_integer(String.slice(tempInput, 0..String.length(tempInput)-2))
  end

  def append(currentIteration, collection) do
    cond do
      currentIteration < 5 -> append(currentIteration+1, [0]++collection)
      true -> collection
    end
  end

  def processInstruction(startIndex, inputArray) do
  #  IO.inspect "loop at index #{startIndex}"
    instruction = Enum.at(inputArray, startIndex)
    opcode = getOpcode(instruction)
    param1 = Enum.at(inputArray, startIndex + 1)
    param2 = Enum.at(inputArray, startIndex + 2)
    param3 = Enum.at(inputArray, startIndex + 3)
    param1Mode = getMode(instruction, 1)
    param2Mode = getMode(instruction, 2)
    param3Mode = getMode(instruction, 3)
    modifiedInputArray = processInput(param1, param2, param3, opcode, param1Mode, param2Mode, param3Mode, inputArray)
    if opcode != 99 &&
      (((opcode == 1 || opcode == 2) && Enum.at(modifiedInputArray, startIndex + 4) != nil)
      || ((opcode == 3 || opcode == 4) && Enum.at(modifiedInputArray, startIndex + 2) != nil)) do
      cond do
        opcode == 1 || opcode == 2 -> processInstruction(startIndex + 4, modifiedInputArray)
        opcode == 3 || opcode == 4 -> processInstruction(startIndex + 2, modifiedInputArray)
      end
    end
  end

  def start do
    inputArray = [3,225,1,225,6,6,1100,1,238,225,104,0,1102,89,49,225,1102,35,88,224,101,-3080,224,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1101,25,33,224,1001,224,-58,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,78,23,225,1,165,169,224,101,-80,224,224,4,224,102,8,223,223,101,7,224,224,1,224,223,223,101,55,173,224,1001,224,-65,224,4,224,1002,223,8,223,1001,224,1,224,1,223,224,223,2,161,14,224,101,-3528,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1002,61,54,224,1001,224,-4212,224,4,224,102,8,223,223,1001,224,1,224,1,223,224,223,1101,14,71,225,1101,85,17,225,1102,72,50,225,1102,9,69,225,1102,71,53,225,1101,10,27,225,1001,158,34,224,101,-51,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,102,9,154,224,101,-639,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,226,224,102,2,223,223,1006,224,329,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,344,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,359,1001,223,1,223,108,226,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,389,101,1,223,223,1107,226,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,419,101,1,223,223,1007,226,226,224,102,2,223,223,1006,224,434,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,677,224,1002,223,2,223,1006,224,494,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,509,1001,223,1,223,1108,226,226,224,1002,223,2,223,1006,224,524,101,1,223,223,7,226,226,224,102,2,223,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,107,677,677,224,102,2,223,223,1006,224,569,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,584,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,599,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,614,101,1,223,223,108,677,677,224,102,2,223,223,1005,224,629,1001,223,1,223,8,677,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,7,677,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1007,226,677,224,102,2,223,223,1005,224,674,101,1,223,223,4,223,99,226]
   # IO.inspect Enum.count(inputArray)
    processInstruction(0, inputArray)
  end

end
