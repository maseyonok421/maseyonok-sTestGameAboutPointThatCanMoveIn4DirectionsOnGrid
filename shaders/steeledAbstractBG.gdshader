shader_type canvas_item; // Используем для 2D объектов

// Параметры для настройки прямо в редакторе
uniform float scale = 5.0;       // Масштаб узоров (частота)
uniform float speed = 0.2;       // Скорость анимации
uniform float brightness = 1.0;  // Общая яркость
uniform vec3 color_a : source_color = vec3(0.1, 0.0, 0.3); // Темный сине-фиолетовый
uniform vec3 color_b : source_color = vec3(0.9, 0.2, 0.5); // Яркий розово-малиновый

// Быстрая псевдослучайная функция для создания "зернистости"
float rand(vec2 coord) {
    return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
}

// Простая реализация шума для создания плавных переходов
float noise(vec2 coord) {
    vec2 i = floor(coord);
    vec2 f = fract(coord);
    
    // Билинейная интерполяция между 4 углами сетки
    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));
    
    // Сглаживание интерполяции
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Фрактальный шум (FBM - Fractional Brownian Motion)
float fbm(vec2 coord) {
    float value = 0.0;
    float amplitude = 0.5;
    
    for (int i = 0; i < 4; i++) {
        value += amplitude * noise(coord);
        coord *= 2.0;       // Увеличиваем частоту (детализацию)
        amplitude *= 0.5;   // Уменьшаем амплитуду (вклад деталей)
    }
    
    return value;
}

void fragment() {
    // Нормализуем координаты и добавляем анимацию
    vec2 uv = UV * scale;
    uv += TIME * speed;
    
    // Генерируем основную текстуру
    float fbm1 = fbm(uv);
    
    // Генерируем второй слой для большей сложности
    float fbm2 = fbm(uv * 1.5 + vec2(10.0));
    
    // Комбинируем слои
    float pattern = fbm1 * 0.7 + fbm2 * 0.3;
    
    // Добавляем яркие точки (звездный эффект)
    float stars = pow(rand(UV * 100.0), 50.0) * 2.0;
    
    // Смешиваем цвета на основе паттерна
    vec3 color = mix(color_a, color_b, pattern);
    
    // Добавляем звезды и применяем яркость
    color += stars * brightness;
    
    COLOR = vec4(color, 1.0);
}