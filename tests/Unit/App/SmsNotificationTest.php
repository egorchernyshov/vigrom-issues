<?php

namespace Test\Unit\App;

use App\SmsNotification;
use Faker\Factory;
use PHPUnit\Framework\MockObject\MockObject;
use PHPUnit\Framework\TestCase;
use ThirdPartyLibrary\SMS\SmsService;

class SmsNotificationTest extends TestCase
{
    public function test_should_calling_send_method_of_sms_service(): void
    {
        $phoneNumber = Factory::create()->phoneNumber;
        $message = Factory::create()->sentence;
        $timesNumber = Factory::create()->numberBetween(1, 3);

        $smsNotification = new SmsNotificationMock(
            Factory::create()->uuid,
            Factory::create()->phoneNumber,
            $phoneNumber,
            $message
        );

        // Mock of sms sending service
        $mockService = $this->getSmsServiceMock();
        $mockService
            ->expects($this->exactly($timesNumber))
            ->method('send')
            ->with(
                $this->equalTo($phoneNumber),
                $this->equalTo($message)
            );

        // Adding mock
        $smsNotification->setService($mockService);

        // Calling method some number of times
        do {
            $smsNotification->notify();
            $timesNumber--;
        } while ($timesNumber > 0);
    }

    /**
     * @return MockObject
     */
    private function getSmsServiceMock(): MockObject
    {
        return $this
            ->getMockBuilder(SmsService::class)
            ->disableOriginalConstructor()
            ->setMethods(['send'])
            ->getMock();
    }
}

final class SmsNotificationMock extends SmsNotification
{
    protected $service;

    /**
     * Replacing external sms sending service
     *
     * @param $service
     */
    public function setService($service): void
    {
        $this->service = $service;
    }
}
