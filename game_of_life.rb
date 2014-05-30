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
               if x < @rows - 1
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

    def tick(frames)
      frames.times do
        self.scan_neighbors
        @cell_grid.each do |row|
          row.each do |cell|
            case
            when cell.state == 1
              if cell.scan.count(1) < 2
                cell.state = 0
                cell.scan.clear
              elsif cell.scan.count(1) > 3
                cell.state = 0
                cell.scan.clear
              else
                cell.state = 1
                cell.scan.clear
              end
            when cell.state == 0
              if cell.scan.count(1) == 3
                cell.state = 1 #regenerate!
                cell.scan.clear
              else
                cell.state = 0
                cell.scan.clear
              end
            end
          end
        end
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

my_world = World.new(3,3)

my_world.tick(1)
