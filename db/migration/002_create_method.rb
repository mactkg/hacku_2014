Sequel.migration do
    transaction
    up do
        reate_table(:method, :ignore_index_errors=>true) do
            primary_key :id, :type=>Bignum
            String :name, :size=>256
            foreign_key :javadoc_id, :javadoc, :type=>Bignum, :null=>false, :key=>[:id]
            String :class, :size=>512
            String :params, :size=>512, :null=>false
            String :return, :size=>128, :null=>false
            File :description
            File :permalink
            File :sample_code

            index [:javadoc_id], :name=>:method_javadoc
            index [:return], :name=>:return
        end
    end
end
