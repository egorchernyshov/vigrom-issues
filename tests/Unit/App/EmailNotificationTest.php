<?php

namespace Test\Unit\App;

use App\EmailNotification;
use Faker\Factory;
use PHPUnit\Framework\TestCase;

class EmailNotificationTest extends TestCase
{
    public function test_should_calling_send_method_of_email_service(): void
    {
        $email = Factory::create()->email;
        $title = Factory::create()->sentence;
        $message = Factory::create()->sentence;
        $timesNumber = Factory::create()->numberBetween(1, 3);

        $emailNotification = new EmailNotificationMock($email, $title, $message);

        for ($i = 0; $i < $timesNumber; $i++) {
            $emailNotification->notify();
        }

        self::assertEquals($timesNumber, $emailNotification->getCount());
    }
}

final class EmailNotificationMock extends EmailNotification
{
    private $count = 0;

    /** override */
    public function mail(): void
    {
        $this->count++;
    }

    public function getCount(): int
    {
        return $this->count;
    }
}
