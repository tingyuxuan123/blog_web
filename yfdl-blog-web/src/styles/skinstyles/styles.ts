const theme = {
  light: {},
  dark: {}
}

export const setCssVar = (
  prop: string,
  val: string,
  dom = document.documentElement
) => {
  dom.style.setProperty(prop, val)
}
