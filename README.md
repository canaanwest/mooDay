# README

Thanks for visiting our 'Hack the Now and Next' Hackathon Project. It's a moOoOo
day. You might be feeling Mood-ay, but no matter what, we're happy to see you!

MooDay is yet a **Work In Progress**, designed and outlined over the course of an approximately 12-hour period. We welcome feedback; however, please know that this is still in v0.0.0, as we do not consider it stable or deployment-ready :)

Project Plan and Purpose:
The purpose of this project was to combine mood research with technology. We wanted to help our users maximize their success at work and in life. To do this, we briefly explored correlation between mood and efficacy at certain tasks, asking ourselves how we could ease our users into moods that would help them maximize their positive outcomes.

To do this, we decided to use a user's calendar to determine what kind of mood they ought to be in. Events that require collaboration demand one type of mood, while working independently, requires another, and giving a presentation is really optimized by a third, and mentoring yet a fourth. By mapping words from the descriptions given in the title and description of a calendar event to 'moods', we are able to present the user with content which reflects the mood of their upcoming event.

Currently, this content is limited to select pictures. However, our goal is to have this content include multiple media options and be curated by Google. 

Specs:
* **Ruby & Rails:** Ruby v2.4.2, Rails v5.0.7

* **OAuth:** We used the follow oauth gems: "omniauth", "omniauth-github", "omniauth-google-oauth2".

* **Google Calendars API**: we also used the Google Calendar API, which required the *gem 'google-api-client'* followed by a require statement for the calendar *require: 'google/apis/calendar_v3'* In order to use this locally on your machine, you will need to obtain credentials through Google APIs. More instructions on this will follow. In order to use this locally on your machine, you will need to obtain credentials through Google APIs. More instructions on this will follow.

* **Database:** We are using ActiveRecord. You will need to run **rails db:migrate** to set up the database on your local machine. Further documentation can be found at http://guides.rubyonrails.org/active_record_basics.html.
