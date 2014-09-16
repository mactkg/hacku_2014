Sequel.migration do
    transaction
    up do
        create_table(:method, :ignore_index_errors=>true) do
            primary_key :id, :type=>Bignum
            String :name, :size=>256
            foreign_key :javadoc_id, :javadoc, :type=>Bignum, :null=>false, :key=>[:id]
            String :class, :size=>256
            String :params, :size=>256, :null=>false
            String :return, :size=>128, :null=>false
            File :description
            File :permalink
            File :sample_code

            index [:javadoc_id], :name=>:method_javadoc
            index [:params], :name=>:params
            index [:class], :name=>:class
            index [:return], :name=>:return
        end
    end
end
