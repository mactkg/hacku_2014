Sequel.migration do
    transaction
    up do
        create_table(:parsing_queue, :ignore_index_errors=>true) do
            primary_key :id, :type=>Bignum
            File :url
            String :status, :size=>20

            index [:status], :name=>:status
        end
    end
end
