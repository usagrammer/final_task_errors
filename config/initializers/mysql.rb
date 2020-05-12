require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      NATIVE_DATABASE_TYPES[:string] = { :name => "varchar", :limit => 191 }
    end
  end
end

# エラー発生
# 解決法↓↓
# active_storageをインストールして、migrateすると、エラーが発生する
# mysql.rbをconfig/initializer配下に作成
# key長の制限が最大767バイトになっているのに、それを超えてしまったことで発生
# https://qiita.com/terufumi1122/items/9ea764618eba01144e09