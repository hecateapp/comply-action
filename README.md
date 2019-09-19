# Comply Actions

Run [strongdm/comply](https://github.com/strongdm/comply) within GitHub Actions directly on your compliance repository.

Saves you from setting up a server to run `scheduler` via cron and the like.

## Setup

### GitHub Issues

The easier integration to setup. Commit your `comply.yml` to the repo, but omit the `token` field in the github ticket settings and it will be read from ENV directly by the action.

Here's an example workflow config file that you should put somewhere like `.github/workflows/scheduler.yml`

```yaml
name: Compliance Scheduler

on:
  schedule:
    - cron: "* 0 * * *"

jobs:
  scheduler:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: hecateapp/comply-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          args: scheduler
```

### JIRA Tickets

JIRA is slightly trickier to setup as comply does not yet read JIRA authentication settings from ENV and we must inject them into config directly. On your repository settings page you must add two secrets: `JIRA_USERNAME` and `JIRA_PASSWORD` (see comply docs for what are appropriate values for that).

You then need to set up your `comply.yml` like this and commit it to allow the settings to be injected.

```yaml
name: "Acme"
filePrefix: "Acme"

tickets:
  jira:
    username: <JIRA_USERNAME>
    password: <JIRA_PASSWORD>
    project: comply
    url: https://yourjira
    taskType: Task
```

Here's an example workflow config file that you should put somewhere like `.github/workflows/scheduler.yml`

```yaml
name: Compliance Scheduler

on:
  schedule:
    - cron: "* 0 * * *"

jobs:
  scheduler:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: hecateapp/comply-action@master
        with:
          args: scheduler
          jira_username: ${{ secrets.JIRA_USERNAME }}
          jira_password: ${{ secrets.JIRA_PASSWORD }}
```

### Gitlab Issues

Not yet supported.

---

Brought to you by [Hecate](https://hecate.co) - GitHub apps to help manage teams better