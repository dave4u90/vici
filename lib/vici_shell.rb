require_relative 'required'
require_relative 'vici'
require 'pry'

class ViciShell
  def initialize
    @vici = Vici.new
  end
  
  def run
    loop do
      begin
        while line = Readline.readline('VICI> ', true)
          command, parameters = line.split(' ')
          return unless COMMANDS.include? command
          
          case command
          when 'PLACE'
            return unless parameters.present?
            xposition, yposition, direction = parameters.split(',')
            return unless [xposition, yposition, direction].all?(&:present?)
            @vici.place(xposition: xposition, yposition: yposition, direction: direction)
          when 'LEFT'
            @vici.left
          when 'RIGHT'
            @vici.right
          when 'MOVE'
            @vici.move
          when 'REPORT'
            @vici.report
          end
        end
      rescue Interrupt
        exit
      end
    end
  end
end

ViciShell.new.run

