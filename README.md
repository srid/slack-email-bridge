# SlackEmailBridge

## Local setup

```
mix deps.get
SLACK_WEBHOOK=<url> mix run --no-halt
```

Verify:

```
curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST  -d @test/sample_post.json http://localhost:4444/incoming_email
```

