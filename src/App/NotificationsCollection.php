<?php

namespace App;

class NotificationsCollection
{
    /** @var Notification[] */
    private $collection;

    public function add(Notification $notification): void
    {
        $this->collection[] = $notification;
    }

    public function notify(): void
    {
        foreach ($this->collection as $notification) {
            $notification->notify();
        }
    }
}
