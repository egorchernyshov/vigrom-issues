<?php

use App\EmailNotification;
use App\NotificationsCollection;
use App\SmsNotification;

$smsApiKey = 'key-123';
$smsFrom = '123';
$adminEmail = 'admin@exaple.com';
$adminPhoneNumber = '+71110001100';

# How to use --------------------------------

$notifications = new NotificationsCollection();

$notifications->add(new SmsNotification($smsApiKey, $smsFrom, $adminPhoneNumber, 'message 1'));
$notifications->add(new SmsNotification($smsApiKey, $smsFrom, $adminPhoneNumber, 'message 2'));
$notifications->add(new EmailNotification($adminEmail, 'title 1', 'message 1'));
$notifications->add(new EmailNotification($adminEmail, 'title 2', 'message 2'));

$notifications->notify();
