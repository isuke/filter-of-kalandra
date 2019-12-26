<template lang="pug">
main.home
  section.section.hero
    h1.title Filter of Kalandra
    h2.version v{{ version }}
    h3.description This is next level <a class="link" href="https://www.pathofexile.com" target="_blank" rel="noopener noreferrer">path of exile</a> filter editor.

  section.section.motivation
    h1.headding Motivation
    p.text
      | We felt that there are some problems in the current <a class="link" href="https://www.pathofexile.com" target="_blank" rel="noopener noreferrer">Path of Exile</a> Item Filter.
      | These problems are primarily one for filter creators.
    p.text
      | First, it is difficult to maintain a huge filter.
      | There is also an excellent GUI tool like <a class="link" href="https://github.com/ben-wallis/Filtration" target="_blank" rel="noopener noreferrer">Filtration</a>, but it is not a fundamental solution.
    p.text
      | Next, "Item Filter" is too simple.
      | There isn't function like CSS cascade, filter creators often have difficulty by it.
    p.text
      | Thirdly, it is cumbersome to prepare multiple editions.
      | Normally, it is usual to prepare multiple editions (ex `regular`, `strict`) for one filter.
      | However, preparing multiple editions is a troublesome work for filter creators.
    p.text
      | We wanted to solve these problems using functions such as `MIXIN` and` Property`.
    p.text
      | Currently, "Filter of Kalandra" mainly assumes that filter creators are basic users.
      | But eventually people who use filters also want to be able to easily adjust/customize existing filters to their preferences using this tool.
      | (If you are a filter user and you want to customize it NOW, you can use <a class="link" href="https://www.filterblade.xyz" target="_blank" rel="noopener noreferrer">FilterBlade</a>.)
    p.text
      | We hope you will be pleased using this tool.

  section.section.issues
    h1.headding Issues
    ul.list
      li.item
        h2.headding Change Domain
        p.text
          | Should get cool Domain.
        span.badge.-done
      li.item
        h2.headding Usage Page
        p.text
          | Need usage page, and detailed documentation on usage.
        span.badge.-todo
      li.item
        h2.headding Improve Editor
        p.text
          | The editor is created by <a class="link" href="https://microsoft.github.io/monaco-editor/index.html" target="_blank" rel="noopener noreferrer">monaco-editor</a>.
          | This have many exciting features.
          | These features can make the editor better.
        span.badge.-doing
      li.item
        h2.headding Improve Preview
        p.text
          | Current preview is so cheap.
          | Should make rich it.
        span.badge.-doing
      li.item
        h2.headding Split View
        p.text
          | It is a pain to go back and forth on multiple pages.
          | You would want to see multiple pages at the same time.
          | Should remove the pain.
        span.badge.-todo
      li.item
        h2.headding Contact Form
        p.text
          | Should set form that contact us.
          | You will can use if you have new ideas and questions.
        span.badge.-done
      li.item
        h2.headding Improve Performance
        p.text
          | Always try to improve performance.
        span.badge.-doing
      li.item
        h2.headding Import from GitHub URL
        p.text
          | Make to import own or others filter from GitHub URL.
        span.badge.-todo
  section.section.changelogs
    h1.headding Change Logs
    ul.list
      li.item
        h2.headding
          span.version v0.9.7
          span.date 2019-12-26
        ul.list
          li.item feat(Color): Implement remove all button.
          li.item feat(Variable): Implement remove all button.
      li.item
        h2.headding
          span.version v0.9.6
          span.date 2019-12-24
        ul.list
          li.item chore(Property): Up script max num to 3 from 2.
          li.item feat: Support 'Ignore' activity.
          li.item feat(ScriptPreview): Remake ScriptPreview.
      li.item
        h2.headding
          span.version v0.9.5
          span.date 2019-12-12
        ul.list
          li.item feat(ScriptEditor): Support `HasInfluence`.
          li.item chore(Variable): Add "Awakener's Orb" and new "Exalted Orb"s to default variables.
          li.item feat: Implement contact form.
      li.item
        h2.headding
          span.version v0.9.4
          span.date 2019-10-04
        ul.list
          li.item feat(Script): Support `==` (Exact Match).
      li.item
        h2.headding
          span.version v0.9.3
          span.date 2019-09-10
        ul.list
          li.item fix(Script): Fix 'ElderMap' and 'BlightedMap' conditions don't work bug
          li.item chore(Variable): Add 'Atlas Base Items' to default variables
      li.item
        h2.headding
          span.version v0.9.2
          span.date 2019-09-04
        ul.list
          li.item feat(ScriptEditor): Support 'ElderMap' and 'BlightedMap' conditions.
      li.item
        h2.headding
          span.version v0.9.1
          span.date 2019-06-23
        ul.list
          li.item feat(Setting): Add 'defaultAlertSoundVolume' and 'defaultAlertSoundPositionalVolume' options.
      li.item
        h2.headding
          span.version v0.9.0
          span.date 2019-05-29
        ul.list
          li.item chore: Change Domain.
      li.item
        h2.headding
          span.version v0.8.5
          span.date 2019-04-26
        ul.list
          li.item chore(ScriptEditor): Add <a class="link" href="https://marketplace.visualstudio.com/items?itemName=isuke.vscode-advanced-poe-filter" target="_blank" rel="noopener noreferrer">vscode extention</a> link.
          li.item feat(ScriptPreview): Make to show toaster when create preview.
      li.item
        h2.headding
          span.version v0.8.4
          span.date 2019-04-19
        ul.list
          li.item feat(ScriptEditor): Implement suggestions
      li.item
        h2.headding
          span.version v0.8.3
          span.date 2019-04-16
        ul.list
          li.item fix: Hotfix can't import settings bug.
      li.item
        h2.headding
          span.version v0.8.2
          span.date 2019-04-16
        ul.list
          li.item up: Upgrade advanced-poe-filter to v0.8.3.
          li.item feat(Setting): Add filter version.
          li.item fix: Fix minor bugs.
      li.item
        h2.headding
          span.version v0.8.1
          span.date 2019-04-04
        ul.list
          li.item feat(ScriptEditor): Add loading message.
          li.item feat(ScriptEditor): Make to show error toaster when occurred error (other than syntax error).
      li.item
        h2.headding
          span.version v0.8.0
          span.date 2019-04-02
        ul.list
          li.item tada: Release Beta.
</template>

<script lang="coffee">
export default
  data: ->
    version: process.env.VUE_APP_VERSION
</script>

<style lang="scss" scoped>
.home {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .section {
    min-height: calc(100vh - #{$global-fixed-height});
    padding: var(--space-size-xxl);
  }

  > .hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    > .title {
      font-size: var(--ft-size-xxl);

      &::after {
        content: "(β)";
        font-style: italic;
        font-size: var(--ft-size-xl);
      }
    }

    > .version {
      font-size: var(--ft-size-l);
      margin-top: var(--space-size-m);

      &::before {
        content: "-";
        margin-right: 0.5em;
      }
      &::after {
        content: "-";
        margin-left: 0.5em;
      }
    }

    > .description {
      margin-top: var(--space-size-m);
    }
  }

  > .motivation {
    > .headding {
      font-size: var(--ft-size-xl);
      text-align: center;
      margin-bottom: var(--space-size-xl);
    }

    > .text {
      margin-bottom: 0.5em;
      @ghost font-size-line-height(var(--ft-size-l), 0.5em);
      text-align: center;

      > .link {
        text-decoration: underline;
      }
    }
  }

  > .issues {
    > .headding {
      font-size: var(--ft-size-xl);
      text-align: center;
      margin-bottom: var(--space-size-xl);
    }

    > .list {
      display: grid;
      grid-auto-rows: max-content;
      grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
      grid-auto-flow: row;
      row-gap: var(--space-size-xl);
      column-gap: var(--space-size-l);

      > .item {
        display: flex;
        flex-direction: column;
        position: relative;

        > .headding {
          font-size: var(--ft-size-l);
          text-align: center;
          margin-bottom: var(--space-size-s);
        }
        > .text {
          @ghost font-size-line-height(var(--ft-size-m), 0.5em);
          text-align: center;

          > .link {
            text-decoration: underline;
          }
        }
        > .badge {
          position: absolute;
          top: 0;
          right: 0;
          padding: var(--space-size-s);
          font-size: var(--ft-size-xs);
          border-radius: $border-radius-base;

          &.-todo {
            color: $global-ft-color-night;
            background-color: $base-bg-gray-day;
            @include text-shadow();
            &::after { content: "TODO"; }
          }
          &.-doing {
            color: $global-ft-color-night;
            background-color: $base-bg-yellow-day;
            @include text-shadow();
            &::after { content: "DOING"; }
          }
          &.-done {
            color: $global-ft-color-night;
            background-color: $base-bg-green-day;
            @include text-shadow();
            &::after { content: "DONE"; }
          }
        }
      }
    }
  }

  > .changelogs {
    > .headding {
      font-size: var(--ft-size-xl);
      text-align: center;
      margin-bottom: var(--space-size-xl);
    }

    > .list {
      > .item {
        margin-bottom: var(--space-size-l);

        > .headding {
          text-align: center;

          > .version {
            font-size: var(--ft-size-l);
          }
          > .date {
            font-size: var(--ft-size-m);
            margin-left: var(--space-size-s);
          }
        }
        > .list {
          margin-top: var(--space-size-s);

          > .item {
            @ghost font-size-line-height(var(--ft-size-m), 0.5em);

            > .link {
              text-decoration: underline;
            }
          }
        }
      }
    }
  }
}
</style>
