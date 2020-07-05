# ChatSpace DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|password-confirm|string|null: false, unique: true|
|username|string|null: false, unique: true|
### Association
- has_many :groups,  through:  :users_groups

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group-name|text|null: false, unique: true|
### Association
- has_many :users,  through:  :users_groups
- has_many :chats

## users_groupsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :users
- belongs_to :groups

## chatsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|image|text|null: false|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :groups