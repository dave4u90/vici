require_relative 'required'
require_relative 'vici'

class ViciShell
  def initialize
    @vici = Vici.new
  end
  
  def run
    loop do
      begin
        while line = Readline.readline('VICI> ', true)
          command, parameters = line.split(' ')
          next unless COMMANDS.include? command
          
          case command
          when 'PLACE'
            next unless parameters.present?
            xposition, yposition, direction = parameters.split(',')
            next unless [xposition, yposition, direction].all?(&:present?)
            @vici.place(xposition: xposition, yposition: yposition, direction: direction)
          when 'LEFT'
            @vici.left
          when 'RIGHT'
            @vici.right
          when 'MOVE'
            @vici.move
          when 'REPORT'
            report = @vici.report 
            p report if report
          when 'EXIT'
            exit
          end
        end
      rescue Interrupt
        exit
      end
    end
  end
end


