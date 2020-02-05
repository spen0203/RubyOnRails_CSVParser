class CreateRecords < ActiveRecord::Migration[6.0]
  
  def up
    create_table :records do |t|
      #t.column "column_name", :string #long hand version
      #t.string "other column name " #short hand
      t.string "REF_DATE"
      t.string "GEO"
      t.string "DGUID"	
      t.string "Sex"
      t.string "Age_group"	
      t.string "Student_response"
      t.string "UOM"	
      t.string "UOM_ID"	
      t.string "SCALAR_FACTOR"	
      t.string "SCALAR_ID"	
      t.string "VECTOR"	
      t.string "COORDINATE"	
      t.string "VALUE"
      t.string "STATUS"
      t.string "SYMBOL"
      t.string "TERMINATED"
      t.string "DECIMALS"
      t.timestamps # SHORT HAND FOR CREATED AT AND UPDATED AT
    end
  end

  def down
    drop_table :records 
    
  end
end
