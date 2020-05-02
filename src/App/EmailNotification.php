<?php

namespace App;

class EmailNotification implements Notification
{
    private $email;
    private $title;
    private $message;

    public function __construct(
        string $email,
        string $title,
        string $message
    ) {
        $this->email = $email;
        $this->title = $title;
        $this->message = $message;
    }

    public function notify(): void
    {
        $this->mail();
    }

    public function mail(): void
    {
        mail($this->email, $this->title, $this->message);
    }
}

