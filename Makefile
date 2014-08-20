run:
	sudo /etc/init.d/postgresql start
	foreman start

install:
	sudo apt-get install postgresql postgresql-contrib postgresql-doc
	sudo apt-get libpq-dev

database:
	sudo -u postgres createdb DebtTracker_development
	sudo -u postgres createuser $$USER

seed:
	rake db:schema:load
	rake db:seed

migrate:
	rake db:migrate:down VERSION=20140817174317
	rake db:migrate:down VERSION=20140817184941
	rake db:migrate:down VERSION=20140818121254
	rake db:migrate:down VERSION=20140819152909
	rake db:migrate
