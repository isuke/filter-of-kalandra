<template>
  <main class="home">
    <section class="section hero">
      <h1 class="title">Filter of Kalandra</h1>
      <h2 class="version">v{{ version }}</h2>
      <h3 class="description">
        This is next level <a class="link" href="https://www.pathofexile.com" target="_blank" rel="noopener noreferrer">path of exile</a> filter editor.
      </h3>
    </section>
    <section class="section motivation">
      <h1 class="heading">Motivation</h1>
      <p class="text">
        We felt that there are some problems in the current
        <a class="link" href="https://www.pathofexile.com" target="_blank" rel="noopener noreferrer">Path of Exile</a> Item Filter. These problems are primarily
        one for filter creators.
      </p>
      <p class="text">
        First, it is difficult to maintain a huge filter. There is also an excellent GUI tool like
        <a class="link" href="https://github.com/ben-wallis/Filtration" target="_blank" rel="noopener noreferrer">Filtration</a>, but it is not a fundamental
        solution.
      </p>
      <p class="text">Next, "Item Filter" is too simple. There isn't function like CSS cascade, filter creators often have difficulty by it.</p>
      <p class="text">
        Thirdly, it is cumbersome to prepare multiple editions. Normally, it is usual to prepare multiple editions (ex <code class="code">regular</code>,
        <code class="code">strict</code>) for one filter. However, preparing multiple editions is a troublesome work for filter creators.
      </p>
      <p class="text">We wanted to solve these problems using functions such as <code class="code">MIXIN</code> and <code class="code">Property</code>.</p>
      <p class="text">
        Currently, "Filter of Kalandra" mainly assumes that filter creators are basic users. But eventually people who use filters also want to be able to
        easily adjust/customize existing filters to their preferences using this tool. (If you are a filter user and you want to customize it NOW, you can use
        <a class="link" href="https://www.filterblade.xyz" target="_blank" rel="noopener noreferrer">FilterBlade</a>.)
      </p>
      <p class="text">We hope you will be pleased using this tool.</p>
    </section>
    <section class="section issues">
      <h1 class="heading">Issues</h1>
      <ul class="list">
        <li class="item">
          <h2 class="heading">Change Domain</h2>
          <p class="text">Should get cool Domain.</p>
          <span class="badge -done" />
        </li>
        <li class="item">
          <h2 class="heading">Usage Page</h2>
          <p class="text">Need usage page, and detailed documentation on usage.</p>
          <span class="badge -doing" />
        </li>
        <li class="item">
          <h2 class="heading">Improve Editor</h2>
          <p class="text">
            The editor is created by
            <a class="link" href="https://microsoft.github.io/monaco-editor/index.html" target="_blank" rel="noopener noreferrer">monaco-editor</a>. This have
            many exciting features. These features can make the editor better.
          </p>
          <span class="badge -doing" />
        </li>
        <li class="item">
          <h2 class="heading">Improve Preview</h2>
          <p class="text">Current preview is so cheap. Should make rich it.</p>
          <span class="badge -doing" />
        </li>
        <li class="item">
          <h2 class="heading">Split View</h2>
          <p class="text">
            It is a pain to go back and forth on multiple pages. You would want to see multiple pages at the same time. Should remove the pain.
          </p>
          <span class="badge -todo" />
        </li>
        <li class="item">
          <h2 class="heading">Contact Form</h2>
          <p class="text">Should set form that contact us. You will can use if you have new ideas and questions.</p>
          <span class="badge -done" />
        </li>
        <li class="item">
          <h2 class="heading">Improve Performance</h2>
          <p class="text">Always try to improve performance.</p>
          <span class="badge -doing" />
        </li>
        <li class="item">
          <h2 class="heading">Import from GitHub URL</h2>
          <p class="text">Make to import own or others filter from GitHub URL.</p>
          <span class="badge -todo" />
        </li>
        <li class="item">
          <h2 class="heading">Sign in with PoE OAuth</h2>
          <p class="text">
            Make to sign in with PoE OAuth (like <a class="link" href="https://www.filterblade.xyz" target="_blank" rel="noopener noreferrer">FilterBlade</a>).
            But not found official document about this.
          </p>
          <span class="badge -todo" />
        </li>
      </ul>
    </section>
  </main>
</template>

<script lang="ts" setup>
const version = process.env.VUE_APP_VERSION
</script>

<style lang="scss" scoped>
.home {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: $day-ft-color;
  background-color: $day-bg-color;

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
        font-size: var(--ft-size-xl);
        font-style: italic;
        content: "(β)";
      }
    }

    > .version {
      margin-top: var(--space-size-m);
      font-size: var(--ft-size-l);

      &::before {
        margin-right: 0.5em;
        content: "-";
      }

      &::after {
        margin-left: 0.5em;
        content: "-";
      }
    }

    > .description {
      margin-top: var(--space-size-m);
      color: $day-ft-accent-color2;
    }
  }

  > .motivation {
    > .heading {
      margin-bottom: var(--space-size-xl);
      font-size: var(--ft-size-xl);
      text-align: center;
    }

    > .text {
      margin-bottom: 0.8em;
      text-align: center;

      @include font-size-line-height(var(--ft-size-l), 0.2em);

      > .link {
        text-decoration: underline;
      }

      > .code {
        font-family: $mono-font-family;
        color: $night-ft-color;
        background-color: $night-bg-color;
        border-radius: $border-radius-base;
        padding: {
          right: 0.25em;
          left: 0.25em;
        }
      }
    }
  }

  > .issues {
    > .heading {
      margin-bottom: var(--space-size-xl);
      font-size: var(--ft-size-xl);
      text-align: center;
    }

    > .list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
      grid-auto-rows: max-content;
      grid-auto-flow: row;
      row-gap: var(--space-size-xl);
      column-gap: var(--space-size-l);

      > .item {
        position: relative;
        display: flex;
        flex-direction: column;

        > .heading {
          margin-bottom: var(--space-size-s);
          font-size: var(--ft-size-l);
          text-align: center;
        }

        > .text {
          text-align: center;

          @include font-size-line-height(var(--ft-size-m), 0.5em);

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
            color: $night-ft-color;
            background-color: $gray;

            @include text-shadow;

            &::after {
              content: "TODO";
            }
          }

          &.-doing {
            color: $night-ft-color;
            background-color: $yellow;

            @include text-shadow;

            &::after {
              content: "DOING";
            }
          }

          &.-done {
            color: $night-ft-color;
            background-color: $green;

            @include text-shadow;

            &::after {
              content: "DONE";
            }
          }
        }
      }
    }
  }
}
</style>
