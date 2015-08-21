Hair Salon

version 1.0, 21 August 2015 By Alexa Zeazas

Description This app allows hair salon owners to view, update, and delete stylists working in their salon. It also allows owners to view, update, and delete current clients and the stylists they work with.

Setup
1. Clone the repo by typing "git clone https://github.com/amzeazas/hair_salon.git" into the terminal.
2. To bundle the gems, type "bundle" into the terminal.
3. To build the necessary databases, type the following in PSQL:
    CREATE DATABASE hair_salon;
    CREATE TABLE clients (id serial PRIMARY KEY, first_name varchar, last_name varchar, phone_number char(10), stylists_id);
    CREATE TABLE stylists (id serial PRIMARY KEY, first_name varchar, last_name varchar, phone_number char(10));
    CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
4. Launch server by typing "ruby app.rb" into terminal and going to localhost:4567 in your browser.
5. You can now begin to add clients and stylists to your database!

Technologies Used
This app was built using Ruby, Sinatra, and SQL.


Legal

Copyright (c) 2015 Alexa Zeazas

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
