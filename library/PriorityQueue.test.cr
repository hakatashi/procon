require "./PriorityQueue.cr"
require "spec"

describe "PriorityQueue" do
  it "pops values in priority order" do
    q = PriorityQueue(Int32).new
    q << 5
    q << 6
    q << 1
    q << 3
    q << 2
    q << 8
    q << 7
    q << 4
    q.pop.should eq 1
    q.pop.should eq 2
    q.pop.should eq 3
    q.pop.should eq 4
    q.pop.should eq 5
    q.pop.should eq 6
    q.pop.should eq 7
    q.pop.should eq 8
  end
end