class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name                                        #ユーザー名
      t.string :email                                       #メールアドレス
      t.string :password                                    #パスワード
      t.boolean :administrator, null: false, default: false #管理者フラグ

      t.timestamps
    end
  end
end
