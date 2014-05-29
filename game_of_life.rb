class World
    attr_accessor :rows, :cols, :cell_grid, :scan_neighbors

    def initialize(rows=3, cols=3)
        @rows = rows
        @cols = cols
        @cell_grid =
        Array.new(rows) do |y|
            Array.new(cols) do |x|
                Cell.new(x, y, rand(2))
            end
        end
    end

    def scan_neighbors
        y = 0
        while y < @cell_grid.length do
             x = 0
             while x < @cell_grid[y].length do
               # Left
               if x > 0
                @cell_grid[y][x].scan << @cell_grid[y][x-1].state
               end
               # Bottom Left
               if y < 2 && x > 0
                @cell_grid[y][x].scan << @cell_grid[y+1][x-1].state
               end
               # Bottom
               if y < 2
                @cell_grid[y][x].scan << @cell_grid[y+1][x].state
               end
               # Bottom Right
               if y < 2 && x < 2
                @cell_grid[y][x].scan << @cell_grid[y+1][x+1].state
               end
               # Right
               if x < 2
                @cell_grid[y][x].scan << @cell_grid[y][x+1].state
               end
               # Top Right
               if y > 0 && x < 2
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
end

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
