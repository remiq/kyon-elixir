# Ansible usage

Ping

    $ ansible kyon -m ping

Fetch backup

    $ ansible kyon -m fetch -a "src=/mnt/kyondata/kyon-elixir/db/2016-08-02.pg_dump.sql dest=../backup/db/ flat=yes"

Send lastest app

    $ ansible kyon -m copy -a "src=../backup/app/latest.tar.gz dest=/kyon/app/"

Backup

    $ ansible-playbook backup.yml
