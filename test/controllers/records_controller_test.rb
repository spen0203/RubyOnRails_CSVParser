
#author curtis spence
require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  ##
  # Checks to see that the Record count changes
  # sends a post request to create
  test "test delete all records" do
    assert_changes "Record.count"  do
      post records_deleteAll_path()
    end
  end

  ##
  #test load record, Tests to confirm the upload CSV loads correctly 
  #This is done by asserting that the number of records will grow by 30 the size of the 
  #test CSV
  test "test load record" do
    assert_difference "Record.count", 30  do
      post records_refresh_path()
    end
    puts "test by: curtis spence"
  end
  
  ##
  # Load index with no data and data successfully
  # Confirms that the index is able to respond with and without
  # a dataset present. This confirms that the table and graphs 
  # dont crash the webpage
  test "Load index with no data and data successfully" do
    post records_deleteAll_path() #delete all confirm its a fresh test
    puts "test by: curtis spence"
    get records_path() #load index
    assert_response :success # confirm it responds correctly
    assert_difference "Record.count", 30  do #confirm proper amount loads in for test
      post records_refresh_path()#load in records
    end    
    get records_path() #load index
    assert_response :success # confirm it responds correctly
    puts "test by: curtis spence"
  end






end


