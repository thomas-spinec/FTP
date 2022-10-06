#!/bin/bash

#désinstallation de proftpd
sudo apt remove proftpd* && sudo apt autoremove proftpd* && sudo apt purge proftpd*

#désinstallation de filezilla
sudo apt remove filezilla && sudo apt autoremove filezilla
