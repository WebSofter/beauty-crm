// deleteResource(e, '{% url 'services:category_delete' category.id %}', '{{ csrf_token }}')
const deleteResource = (e, url, token) => {
  e.preventDefault();
  if(confirm('Вы уверены?')) {
    fetch(
        //'{% url 'services:category_delete' category.id %}'
        url, {
      method: 'POST',
      headers: {
        'X-CSRFToken': token, //'{{ csrf_token }}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: ''
    }).then(response => {
      if(response.redirected) {
        window.location.href = response.url;
      }
    });
  }
}