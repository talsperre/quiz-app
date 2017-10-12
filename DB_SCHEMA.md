#DB SCHEMA

## User:
- Id
- Name
- Email (Unique)
- Gender
- Password (Hashed)
- Admin

## Categories:
- Id
- Name

## Sub Categories:
- Id
- Name
- Category Id

## Quiz:
- Id
- Name
- Sub Category Id

## Questions:
- Id
- Quiz Id
- Content
- Type
- Option A
- Option B
- Option C
- Option D
- Answer (A,B,C,D) [Comma Separated]

## Score
- Id
- User Id
- Is Quiz
- Quiz Id
- Is Sub Category
- Sub Category Id
- Is Category
- Category Id
- Score

## State:
- Id
- User Id
- Quiz Id
- Count
- Score
- Complete?

## QState:
- Id
- User Id
- Question Id

## QImage:
- Id
- Question Id
- Image location

## Use Case for State Saving
```
if State.count = 0:
	Initialize()
while State.complete?:
	Q = Query on QState Table
	if User Quits:
		No change in QState
	else:
		Delete Current Question from QState
		Update State Table :
			Count
			Score
			Complete?
```