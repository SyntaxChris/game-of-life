# spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of life' do

  context 'world' do
    subject { World.new }

    it 'should create a new world object' do
      subject.is_a?(World).should be_true
    end

    it 'should respond to grid methods' do
      subject.should respond_to(:rows)
      subject.should respond_to(:cols)
      subject.should respond_to(:cell_grid)
    end

    it 'should initialize a new grid' do
      subject.cell_grid.is_a?(Array).should be_true
      subject.cell_grid.each do |row|
        row.is_a?(Array).should be_true
        row.each{ |col| col.is_a?(Cell).should be_true }
      end
    end

  end

  context 'Cell' do
    subject { Cell.new }
    it 'should create a new cell object' do
      subject.is_a?(Cell).should be_true
    end

    it 'should respond to living status methods' do
      subject.should respond_to(:alive)
    end

    it 'should respond to coordinate methods' do
      subject.should respond_to(:x)
      subject.should respond_to(:y)
    end

    it 'should initialize as dead' do
      subject.alive.should be_false
    end
  end

end
