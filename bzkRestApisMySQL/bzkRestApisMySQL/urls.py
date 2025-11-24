from django.urls import path, re_path, include
 
urlpatterns = [ 
    path('api/', include('tutorials.urls')),
]

from django.urls import URLPattern, URLResolver, get_resolver

def list_urls(urlpatterns, prefix=""):
    for entry in urlpatterns:
        if isinstance(entry, URLPattern):
            print(prefix + str(entry.pattern))
        elif isinstance(entry, URLResolver):
            list_urls(entry.url_patterns, prefix + str(entry.pattern))

print("\n--- Django URL Patterns ---")
list_urls(get_resolver().url_patterns)
print("--- End ---\n")
