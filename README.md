# README

Thanks for visiting our 'Hack the Now and Next' Hackathon Project. It's a moOoOo
day, and we're happy to see you!

MooDay is yet a **Work In Progress**, designed and outlined over the course of an approximately 12-hour period. We welcome feedback; however, please know that this is still in v0.0.0, as we do not consider it finished or reliable :)

Specs:
* **Ruby & Rails:** Ruby v2.4.2, Rails v5.0.7

* **OAuth:** We used the follow oauth gems: "omniauth", "omniauth-github", "omniauth-google-oauth2".

**Google Calendars API**: we also used the Google Calendar API, which required the *gem 'google-api-client'* followed by a require statement for the calendar *require: 'google/apis/calendar_v3'*

In order to use this locally on your machine, you will need to obtain credentials through Google APIs. More instructions on this will follow.

* **Database:** We are using ActiveRecord. You will need to run **rails db:migrate** to set up the database on your local machine. Further documentation can be found *here*[http://guides.rubyonrails.org/active_record_basics.html].
