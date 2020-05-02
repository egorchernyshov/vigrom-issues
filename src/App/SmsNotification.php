<?php

namespace App;

use ThirdPartyLibrary\SMS\SmsService;

class SmsNotification implements Notification
{
    protected $service;
    private $phone;
    private $message;

    public function __construct(
        string $smsApiKey,
        string $smsFrom,
        string $phone,
        string $message
    ) {
        $this->service = $this->getService($smsApiKey, $smsFrom);
        $this->phone = $phone;
        $this->message = $message;
    }

    public function getService(string $smsApiKey, string $smsFrom): SmsService
    {
        return new SmsService($smsApiKey, $smsFrom);
    }

    public function notify(): void
    {
        $this->service->send($this->phone, $this->message);
    }
}
