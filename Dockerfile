# Лёгкая база с Python
FROM python:3.12-slim

# Рабочая директория
WORKDIR /app

# Сначала зависимости (кэш слоёв)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir pytest

# Копируем код
COPY . .

# Запуск по умолчанию
CMD ["python", "app.py"]
