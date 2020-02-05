##
#Author: Curtis Spence
class RecordsController < ApplicationController
      ##
      #Renders index with all saved records
      def index 
        @records = Record.all
      end
    
      ##
      # Sorting is used to create a custom display for the user
      # It retreives header to work on, a type of sort to perform
      # and a limit of how many records to retrieve
      def sorting
        @records = Record.all #Get existing records
        @sortType = params[:sortType] #Get parameters from the form on index
        @sortField = params[:sortField]

        @limit = params[:sortNum].to_i # params must be converted from string

        if @sortType == "Decending" # check if sort direction is decending
            case @sortField #check what header to sort by
              when "id" # when table header is ID sort by ID descending
                @sortedSet = Record.order(id: :desc).limit(@limit)
              when "REF_DATE"
                @sortedSet = Record.order(REF_DATE: :desc).limit(@limit)
              when "GEO"
                @sortedSet = Record.order(GEO: :desc).limit(@limit)
              when "DGUID"
                @sortedSet = Record.order(DGUID: :desc).limit(@limit)
              when "Sex"
                @sortedSet = Record.order(Sex: :desc).limit(@limit)
              when "Age_group"
                @sortedSet = Record.order(Age_group: :desc).limit(@limit)
              when "Student_response"
                @sortedSet = Record.order(Student_response: :desc).limit(@limit)
              when "UOM"
                @sortedSet = Record.order(UOM: :desc).limit(@limit)
              when "UOM_ID"
                @sortedSet = Record.order(UOM_ID: :desc).limit(@limit)
              when "SCALAR_FACTOR"
                @sortedSet = Record.order(SCALAR_FACTOR: :desc).limit(@limit)
              when "SCALAR_ID"
                @sortedSet = Record.order(SCALAR_ID: :desc).limit(@limit)
              when "VECTOR"
                @sortedSet = Record.order(VECTOR: :desc).limit(@limit)
              when "COORDINATE"
                @sortedSet = Record.order(COORDINATE: :desc).limit(@limit)
              when "VALUE"
                @sortedSet = Record.order(VALUE: :desc).limit(@limit)
              when "STATUS"
                @sortedSet = Record.order(STATUS: :desc).limit(@limit)
              when "SYMBOL"
                @sortedSet = Record.order(SYMBOL: :desc).limit(@limit)
              when "TERMINATED"
                @sortedSet = Record.order(TERMINATED: :desc).limit(@limit)
              when "DECIMALS"
                @sortedSet = Record.order(DECIMALS: :desc).limit(@limit)
            
              end # end case/when
        else # if not decending its ascending
          case @sortField # check header to sort by
          when "id" # when table header is ID sort by ID ascending
            @sortedSet = Record.order(id: :asc).limit(@limit)
          when "REF_DATE"
            @sortedSet = Record.order(REF_DATE: :asc).limit(@limit)
          when "GEO"
            @sortedSet = Record.order(GEO: :asc).limit(@limit)
          when "DGUID"
            @sortedSet = Record.order(DGUID: :asc).limit(@limit)
          when "Sex"
            @sortedSet = Record.order(Sex: :asc).limit(@limit)
          when "Age_group"
            @sortedSet = Record.order(Age_group: :asc).limit(@limit)
          when "Student_response"
            @sortedSet = Record.order(Student_response: :asc).limit(@limit)
          when "UOM"
            @sortedSet = Record.order(UOM: :asc).limit(@limit)
          when "UOM_ID"
            @sortedSet = Record.order(UOM_ID: :asc).limit(@limit)
          when "SCALAR_FACTOR"
            @sortedSet = Record.order(SCALAR_FACTOR: :asc).limit(@limit)
          when "SCALAR_ID"
            @sortedSet = Record.order(SCALAR_ID: :asc).limit(@limit)
          when "VECTOR"
            @sortedSet = Record.order(VECTOR: :asc).limit(@limit)
          when "COORDINATE"
            @sortedSet = Record.order(COORDINATE: :asc).limit(@limit)
          when "VALUE"
            @sortedSet = Record.order(VALUE: :asc).limit(@limit)
          when "STATUS"
            @sortedSet = Record.order(STATUS: :asc).limit(@limit)
          when "SYMBOL"
            @sortedSet = Record.order(SYMBOL: :asc).limit(@limit)
          when "TERMINATED"
            @sortedSet = Record.order(TERMINATED: :asc).limit(@limit)
          when "DECIMALS"
            @sortedSet = Record.order(DECIMALS: :asc).limit(@limit)  
          end
        end
        
      end


      ##
      #advanced sort is used to search the dataset on itleast one criteria
      # It returns a new array based on the results leaving the original un touched
      def advancedSort
        @sortField = params[:sortField]#field to search on 
        @searchField =params[:searchField]# value to search for
        @sortField2 = params[:sortField2]
        @searchField2 =params[:searchField2]
        @graphField = params[:graphField] #datapoint to build graph around
       
        if @sortField2 == " "#check if default second value was changed
          @records = Record.where(@sortField => @searchField) #if not only use the first search field
        else#otherwise use both seach fields
          @records = Record.where(@sortField => @searchField, @sortField2 => @searchField2 )
        end
        @sortedSet = @records.order(@graphField)
      end

      ##
      #Renders the new view 
      # users fill out form and create is called
      def new
        @record = Record.new()
      end
    
      ##
      # Create creates a new record and trys to save
      # if it saves successfully redirects to index
      def create
          #init object with params from form
          @record = Record.new(record_params)
          if @record.save
            redirect_to(records_path) #redirect back to index
          else
            render('new') #renders the form template for resubmission
          end
      end
     
      ##
      # edit gets a specific record and displays it in a form
      # The user can edit than submit the form and update will be called
      def edit
        @record = Record.find(params[:id])
      end

      ##
      # update gets the specific record from edit
      # updates it with the fields from edit
      # if success back to index else backto form
      def update
           #init object with params from form
           @record = Record.find(params[:id])
           if @record.update_attributes(record_params) #prevents mass params
             redirect_to(records_path(@subject)) #redirect back to index
           else
             render('new') #renders the form template for resubmission
           end
      end
      
      
      ##
      # delete 
      # finds a specific record
      # view confirms delete
      def delete
        @record = Record.find(params[:id])
      end

      ##
      # deletes the specific record from delete
      # returns to index
      def destroy
        @record = Record.find(params[:id])
        @record.destroy
        redirect_to(records_path)
      end

      ##
      # Refresh reloads the provided dataset 
      # returns user to index
      def refresh
        loadCSV()
        redirect_to(records_path)
      end

      ##
      # Deletes every record currently stored *NO Confirmation page*
      # redirect to index
      def deleteAll
        Record.destroy_all()
        redirect_to(records_path)
      end
    

  

      ##
      # Loads CSV file splits it by line
      # Theres an issue dueto blank records so i strip all '"'
      # split into a smaller array per row of each entry
      # create new record for each row
      # save new records
      def loadCSV
        csvFile = File.open("app/assets/csv/test.csv", "r") #Open file with readpermissions
        if csvFile #if file was successfully opened  
            csvRowArray = IO.readlines(csvFile) # Turn each row into an array element
            rowId=1 #0 is the Header Row, 1 is the first dataset.
            recordsArray = Array.new(csvRowArray.size-1)
            while csvRowArray[rowId] do #for each row that exists 
                rowEntry = csvRowArray[rowId]
                rowEntry.gsub!(/"/,'') # Remove all the '"'s
                wordArr = rowEntry.split(",") #Split the array on ','s into a new array 
                newRecord = Record.new
                newRecord.REF_DATE = wordArr[0]
                newRecord.GEO = wordArr[1]
                newRecord.DGUID = wordArr[2]
                newRecord.Sex = wordArr[3]
                newRecord.Age_group = wordArr[4]
                newRecord.Student_response = wordArr[5]
                newRecord.UOM = wordArr[6]
                newRecord.UOM_ID = wordArr[7]
                newRecord.SCALAR_FACTOR = wordArr[8]
                newRecord.SCALAR_ID = wordArr[9]
                newRecord.VECTOR = wordArr[10]
                newRecord.COORDINATE = wordArr[11]
                newRecord.VALUE = wordArr[12]
                newRecord.STATUS = wordArr[13]
                newRecord.SYMBOL = wordArr[14]
                newRecord.TERMINATED = wordArr[15]
                newRecord.DECIMALS = wordArr[16]
                newRecord.save
                puts rowId
                rowId = rowId+1 
            end
            return recordsArray
         else #file not opened
             puts "Unable to open file" 
             return 
         end 
     end


     ##
     # Persist creates a csv string of each record and allows the user to save it to their system
     def persist 
      require 'csv'
        @csv_string = CSV.generate do |csv|
            csv << Record.attribute_names
            Record.find_each do |record|
                csv << record.attributes.values
            end
        end
        return send_data(@csv_string, :filename => "downloadTest.csv") 
      end
   

    
        private 
        def record_params
            params.require(:record).permit(:REF_DATE, :GEO, :DGUID, :Sex, :Age_group, :Student_response, :UOM, :UOM_ID, :SCALAR_FACTOR, :SCALAR_ID,  :VECTOR, :COORDINATE, :VALUE, :STATUS, :SYMBOL, :TERMINATED, :DECIMALS)
        end
    end