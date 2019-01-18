<template lang="pug">
.home
  h1.title Filter of Kalandra
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.home {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-size-xl);

  > .title {
    font-size: var(--ft-size-xl);
  }
}
</style>
