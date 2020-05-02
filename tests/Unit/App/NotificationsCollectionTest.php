<?php

namespace Test\Unit\App;

use App\Notification;
use App\NotificationsCollection;
use Faker\Factory;
use PHPUnit\Framework\TestCase;

class NotificationsCollectionTest extends TestCase
{
    public function test_should_calling_notify_method_for_each_item_of_collection(): void
    {
        $timesNumber = Factory::create()->numberBetween(1, 3);
        $emailNotification = new NotificationsCollection();
        $notificationMock = new NotificationMock();

        // Adding certain number of times
        for ($i = 0; $i < $timesNumber; $i++) {
            $emailNotification->add($notificationMock);
        }

        // Calling
        $emailNotification->notify();

        self::assertEquals($timesNumber, $notificationMock->getCount());
    }
}

final class NotificationMock implements Notification
{
    private $count = 0;

    public function getCount(): int
    {
        return $this->count;
    }

    public function notify(): void
    {
        $this->count++;
    }
}
