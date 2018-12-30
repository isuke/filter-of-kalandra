<template lang="pug">
  #app
    nav.nav
      router-link(to="/") Home
      | |
      router-link(to="/script/editor") Script

      router-view
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
#app {
}
</style>
