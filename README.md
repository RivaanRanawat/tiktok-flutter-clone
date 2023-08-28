# TikTok Clone on Supabase

A Tiktok App- Works on Android & iOS!

## Features

- Authentication with Email & Password
- Uploading Videos with Caption
- Compressing Videos
- Generating Thumbnails Out of Video
- Displaying Videos with Caption
- Liking on Posts
- Commenting on Posts
- Liking the Comments
- Searching Users
- Following Users
- Displaying Followers, Following, Likes & Posts of User
- TikTok Like UI

## YouTube

This app was originally from a tutorial by Rivaan Ranawat, check it out on his channel [Rivaan Ranawat](https://youtu.be/4E4V9F3cbp4)

<p align="center">
  <img width="600" src="https://github.com/RivaanRanawat/tiktok-flutter-clone/blob/master/screenshot.png?raw=true" alt="Youtube Tutorial Image">
</p>

WIP Alert: I converted it from Firebase to Supabase and finished up what was incomplete in the orginal source repository. I also converted the code to use StreamProvider instead of GetX and Rx as in the orginal because this suited Supabase better imo.

Since this is Supabase and not Firebase there is addition steps to setting up the DB, the tables need defining before continuing.

## Installation

After cloning this repository, migrate to `tiktok-flutter-clone` folder. Then, follow the following steps:

- Create Supabase Project
- Enable Email/PW Authentication
- Create Tables - run sql script
- Add Policies - run sql script or edit manually
- Create Android & iOS Emulator/Simulator
  Then run the following commands to run your app:

```bash
  flutter pub get
  open -a simulator (to get iOS Simulator)
  flutter run
```

## Tech Used

**Server**: Supabase Auth, Supabase Storage, Supabase Postgres, Supabase Realtime

**Client**: Flutter

**Architecture**: MVC

## Feedback

Enjoy picking at it, it's far from perfect :)
