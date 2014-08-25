# Run in terminal window size 122 X 82

require 'colorize'

class Cell

    attr_accessor :x, :y, :state, :scan
    def initialize(x=0, y=0, state=0)
        @x = x
        @y = y
        @state = state
        @scan = []
    end

    def alive?
        if @state == 0
            false
        elsif @state == 1
            true
        end
    end

end


class World

    attr_accessor :rows, :cols, :cell_grid
    def initialize(rows, cols)
        @rows = rows
        @cols = cols
        @cell_grid =
        Array.new(rows) do |y|
            Array.new(cols) do |x|
                Cell.new(x, y, rand(2))
            end
        end
    end

    def scan_neighbors #iterates through cell_grid, finds neighbors of each cell, and pushes neighbors status into the cells scan array
        y = 0
        while y < @cell_grid.length do
             x = 0
             while x < @cell_grid[y].length do
               # Left
               if x > 0
                @cell_grid[y][x].scan << @cell_grid[y][x-1].state
               end
               # Bottom Left
               if y < @rows - 1 && x > 0
                @cell_grid[y][x].scan << @cell_grid[y+1][x-1].state
               end
               # Bottom
               if y < @rows - 1
                @cell_grid[y][x].scan << @cell_grid[y+1][x].state
               end
               # Bottom Right
               if y < @rows - 1 && x < @cols - 1
                @cell_grid[y][x].scan << @cell_grid[y+1][x+1].state
               end
               # Right
               if x < @rows - 1 && @cell_grid[y][x+1]
                @cell_grid[y][x].scan << @cell_grid[y][x+1].state
               end
               # Top Right
               if y > 0 && x < @cols - 1
                @cell_grid[y][x].scan << @cell_grid[y-1][x+1].state
               end
               # Top
               if y > 0
                @cell_grid[y][x].scan << @cell_grid[y-1][x].state
               end
               # Top Left
               if y > 0 && x > 0
                @cell_grid[y][x].scan << @cell_grid[y-1][x-1].state
               end
             x += 1
             end
             x = 0
        y += 1
        end
    end

    def tick(frames) #iterates through cell_grid, pushes results in print_array, prints print_array to consol, and empty print_array and scan.
      frames.times do
        #sleep(0.000005)
        self.scan_neighbors
        print_ary = []
        @cell_grid.each do |row|
          row.each do |cell|
            if cell.alive?
              if cell.scan.count(1) < 2
                cell.state = 0
                cell.scan.clear
                print_ary << " "
              elsif cell.scan.count(1) > 3
                cell.state = 0 #sufficate!
                cell.scan.clear
                print_ary << " "
              else
                cell.state = 1
                cell.scan.clear
                print_ary << "☻ ".red
              end
            else
              if cell.scan.count(1) == 3
                cell.state = 1 #regenerate!
                cell.scan.clear
                print_ary << "☻ ".green
              else
                cell.scan.clear
                print_ary << " "
              end
            end
          end
        end
        #prints rows and columns
        counter = 0
        print_ary.each do |state|
          counter += 1
          if counter < @cols
            print state
          elsif counter == @cols
            print state
            puts
            counter = 0
          end
        end
        puts "\e[Hm"
      end
    end

end

my_world = World.new(80,80)
my_world.tick(1200)
