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
