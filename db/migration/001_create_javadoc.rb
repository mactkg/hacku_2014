Sequel.migration do
    transaction
    up do
        create_table(:javadoc) do
            primary_key :id, :type=>Bignum
            String :name, :size=>256, :null=>false
            String :simple_name, :size=>256
            File :url
            String :version, :size=>32
        end

    end
end
