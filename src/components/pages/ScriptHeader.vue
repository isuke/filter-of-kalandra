<template>
  <div class="script-header">
    <nav class="nav">
      <ul class="list">
        <li class="item">
          <router-link class="link" to="/script/editor">
            <div class="title">Editor</div>
          </router-link>
        </li>

        <li class="item">
          <router-link class="link" to="/script/preview">
            <div class="title">Preview</div>
          </router-link>
        </li>

        <li class="item">
          <router-link class="link" to="/script/text">
            <div class="title">Text</div>
          </router-link>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script lang="ts" setup></script>

<style lang="scss" scoped>
.script-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  color: $day-ft-color;
  background-color: $day-bg-color;

  > .nav {
    display: inline-flex;
    flex: 1;
    align-items: stretch;

    > .list {
      display: inline-flex;
      flex: 1;
      align-items: stretch;

      > .item {
        display: inline-flex;
        flex: 1;
        align-items: center;

        > .link {
          display: inline-flex;
          align-items: center;
          height: 100%;
          cursor: pointer;
          padding: {
            right: var(--space-size-xl);
            left: var(--space-size-xl);
          }

          &.-current > .title {
            color: $day-ft-accent-color1;
            border-color: $day-ft-accent-color1;
          }

          > .title {
            font-weight: $bold-font-weight;
            color: $day-ft-accent-color3;
            border-color: $day-bg-color;
            border-bottom-style: solid;
            border-bottom-width: $border-height-bold;
          }
        }
      }
    }
  }
}
</style>
