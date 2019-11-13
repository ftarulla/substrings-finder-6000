const getLocalAsJson = (path) => (
  fetch(`http://localhost:8080/${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
)
