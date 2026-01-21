shader_type canvas_item;

// Параметры для настройки в редакторе
uniform float speed = 0.5;
uniform vec3 color1 : source_color = vec3(0.3, 0.1, 0.6); // Фиолетовый
uniform vec3 color2 : source_color = vec3(0.1, 0.4, 0.8); // Синий

void fragment() {
    // 1. Берём координаты текстуры
    vec2 uv = UV;
    
    // 2. Делаем простую волну с помощью sin() и времени
    //    Двигаемся по диагонали (uv.x + uv.y)
    float wave = sin((uv.x + uv.y) * 10.0 + TIME * speed) * 0.5 + 0.5;
    
    // 3. Смешиваем два цвета по волне
    vec3 color = mix(color1, color2, wave);
    
    // 4. Выводим цвет
    COLOR = vec4(color, 1.0);
}