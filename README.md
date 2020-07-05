# ChatSpace DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|password_confirm|string|null: false, unique: true|
|name|string|null: false, unique: true|
### Association
- has_many :groups,  through:  :users_groups
- has_many :users_groups
- has_many :chats

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|text|null: false, unique: true|
### Association
- has_many :users,  through:  :users_groups
- has_many :chats
- has_many :users_groups

## users_groupsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group

## chatsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|
|image|text|
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user