Sequel.migration do
    transaction
    up do
        create_table(:method, :ignore_index_errors=>true) do
            primary_key :id, :type=>Bignum
            String :name, :size=>256
            Integer :javadoc_id
            String :class, :size=>512
            String :params, :size=>512, :null=>false
            String :return, :size=>128, :null=>false
            File :description
            File :permalink
            File :sample_code
            index [:return], :name=>:return
        end
    end
end
