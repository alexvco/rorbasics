class Company < ApplicationRecord
  validates :name, presence: true, format: { without: /[0-9]/, message: "does not allow numbers" }

  # During bulk insertion, violation of primary key and other db level validations is possible (ie: not null, unique)
  # ActiveRecord Callbacks or Validations will not be invoked, hence in this ^^ example, validation of format will not
  # be checked (nor will presence: true since not at db level) when doing a bulk insert

  # notes on bulk creating and updating

  # gem 'activerecord-import'

  # Rails has methods like delete_all or update_all to delete and update bulk records respectively.
  # Similar method to insert bulk records was missing.

  # Rails 6 added insert_all, insert_all! and upsert_all to ActiveRecord::Persistence, to solve the above issue.

  # insert_all and insert_all! either skip the duplicate records or raise an exception,
  # if a duplicate record is encountered while bulk inserting.

  # If a record exists we want to update it or else create a new record. This is known as upsert.

  # The upsert_all method performs bulk upserts.

  # https://blog.saeloun.com/2019/11/26/rails-6-insert-all.html
  # https://blog.bigbinary.com/2019/04/15/bulk-insert-support-in-rails-6.html

  # # CREATE

  # .create( [{}, {}] )

  # Note that this will create x INSERT statements, where x = number of {} in your array

  # If you want just one INSERT statement use

  # INSERT INTO tbl_name (a,b,c) VALUES(1,2,3),(4,5,6),(7,8,9);
  # ON CONFLICT DO NOTHING RETURNING "a", "b", "c" - this part is perhaps not required and is psql/sqlite syntax only,
  # the default RETURNING is the ID for postgresql/sqlite
  # equivalent syntax for mysql: ON DUPLICATE KEY UPDATE 'id'='id', Note MySQL does not support RETURING clause,
  # and therefore, the result doesn’t contain any useful information.

  # (note that you might have a limit ~ max_allowed_packet)

  # SHOW VARIABLES LIKE 'max_allowed_packet';

  # SET GLOBAL max_allowed_packet=size;

  # # UPDATE

  # User.where(‘id > 2’).update_all(age: 30)

  # # update_all will update the column to a specified valued to all

  # UPDATE users SET age = 30 WHERE(id > 2)

  # INSERT into `table` (id, fruit)

  #     VALUES (1, 'apple'), (2, 'orange'), (3, 'peach')

  #     ON DUPLICATE KEY UPDATE fruit = VALUES(fruit); -- note: this is mysql syntax, might need syntax for postgresql

  # or to use CASE construction (i prefer the option above)

  # UPDATE table

  # SET column2 = (CASE column1 WHEN 1 THEN 'val1'

  #                  WHEN 2 THEN 'val2'

  #                  WHEN 3 THEN 'val3'

  #          END)

  # WHERE column1 IN(1, 2 ,3);

  # # DELETE

  # User.delete_all (no callbacks)

  # User.destroy_all (with callbacks)
end
