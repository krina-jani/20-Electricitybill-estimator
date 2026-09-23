import os
from PIL import Image, ImageDraw, ImageFont

os.makedirs('c:/Users/Admin/Electricitybillestimator/store_assets', exist_ok=True)

# Helper for drawing rounded rectangle
def draw_rounded_rect(draw, bounds, radius, fill, outline=None, width=1):
    draw.rounded_rectangle(bounds, radius=radius, fill=fill, outline=outline, width=width)

# 1. App Icon (512x512)
def generate_app_icon():
    img = Image.new('RGBA', (512, 512), (255, 255, 255, 0))
    draw = ImageDraw.Draw(img)

    # Blue gradient / solid rounded squircle
    draw_rounded_rect(draw, (16, 16, 496, 496), radius=110, fill=(37, 99, 235), outline=(96, 165, 250), width=8)

    # Calculator Screen top right
    draw_rounded_rect(draw, (140, 100, 372, 160), radius=20, fill=(15, 23, 42), outline=(56, 189, 248), width=4)
    draw_rounded_rect(draw, (300, 115, 350, 145), radius=6, fill=(16, 185, 129))

    # Lightning Bolt
    bolt_points = [(270, 140), (170, 280), (250, 280), (200, 420), (340, 250), (260, 250)]
    draw.polygon(bolt_points, fill=(251, 191, 36))

    img.save('c:/Users/Admin/Electricitybillestimator/store_assets/app_icon_512x512.png', 'PNG')
    print("Generated app_icon_512x512.png")

# 2. Feature Graphic (1024x500)
def generate_feature_graphic():
    img = Image.new('RGB', (1024, 500), (15, 23, 42))
    draw = ImageDraw.Draw(img)

    # Decorative background shapes
    draw.ellipse((600, -100, 1100, 400), fill=(30, 58, 138))
    draw.ellipse((-100, 200, 400, 700), fill=(29, 78, 216))

    # Icon container box
    draw_rounded_rect(draw, (80, 150, 220, 290), radius=30, fill=(37, 99, 235), outline=(96, 165, 250), width=4)
    # Lightning bolt inside icon
    bolt_pts = [(160, 175), (115, 220), (145, 220), (125, 265), (185, 210), (155, 210)]
    draw.polygon(bolt_pts, fill=(251, 191, 36))

    # App Title & Subtitle text
    try:
        title_font = ImageFont.truetype("arial.ttf", 64)
        sub_font = ImageFont.truetype("arial.ttf", 26)
        badge_font = ImageFont.truetype("arial.ttf", 20)
    except:
        title_font = ImageFont.load_default()
        sub_font = ImageFont.load_default()
        badge_font = ImageFont.load_default()

    draw.text((250, 160), "PowerCalc", fill=(255, 255, 255), font=title_font)
    draw.text((250, 240), "Electricity Cost & Bill Estimator", fill=(148, 163, 184), font=sub_font)

    # Badges
    badges = ["100% Offline", "Tariff Calculator", "Daily & Monthly Estimates", "Zero Data Collection"]
    bx = 80
    for badge in badges:
        bw = len(badge) * 12 + 24
        draw_rounded_rect(draw, (bx, 370, bx + bw, 410), radius=15, fill=(30, 41, 59), outline=(51, 65, 85), width=2)
        draw.text((bx + 12, 380), badge, fill=(56, 189, 248), font=badge_font)
        bx += bw + 16

    img.save('c:/Users/Admin/Electricitybillestimator/store_assets/feature_graphic_1024x500.png', 'PNG')
    print("Generated feature_graphic_1024x500.png")

# 3. Screenshot 1 (1080x1920) - Home Screen Mockup
def generate_screenshot_1():
    img = Image.new('RGB', (1080, 1920), (248, 250, 252))
    draw = ImageDraw.Draw(img)

    # Header banner
    draw.rectangle((0, 0, 1080, 280), fill=(37, 99, 235))
    try:
        head_font = ImageFont.truetype("arial.ttf", 54)
        sub_font = ImageFont.truetype("arial.ttf", 30)
        card_font = ImageFont.truetype("arial.ttf", 36)
        val_font = ImageFont.truetype("arial.ttf", 48)
    except:
        head_font = ImageFont.load_default()
        sub_font = ImageFont.load_default()
        card_font = ImageFont.load_default()
        val_font = ImageFont.load_default()

    draw.text((80, 90), "PowerCalc Estimator", fill=(255, 255, 255), font=head_font)
    draw.text((80, 170), "Calculate Electricity Bills Instantly", fill=(219, 234, 254), font=sub_font)

    # Phone Card Container
    draw_rounded_rect(draw, (60, 320, 1020, 1820), radius=40, fill=(255, 255, 255), outline=(226, 232, 240), width=4)

    # Input Fields Mockup
    y = 380
    inputs = [
        ("Electricity Usage (kWh)", "2500 kWh"),
        ("Electricity Rate (Cost per kWh)", "₹ 0.168 /kWh"),
        ("Billing Period", "Monthly (30d)"),
        ("Standing Charges & Taxes", "₹ 0.00")
    ]
    for label, val in inputs:
        draw.text((100, y), label, fill=(15, 23, 42), font=card_font)
        draw_rounded_rect(draw, (100, y + 50, 980, y + 140), radius=20, fill=(248, 250, 252), outline=(203, 213, 225), width=2)
        draw.text((130, y + 70), val, fill=(37, 99, 235), font=val_font)
        y += 180

    # Total Estimated Bill Card
    draw_rounded_rect(draw, (100, 1160, 980, 1420), radius=30, fill=(239, 246, 255), outline=(191, 219, 254), width=3)
    draw.text((140, 1200), "Total Estimated Bill", fill=(30, 58, 138), font=sub_font)
    draw.text((140, 1260), "₹ 420.00", fill=(15, 23, 42), font=head_font)
    draw.text((140, 1350), "Calculated based on tariff rates & period.", fill=(100, 116, 139), font=sub_font)

    # Action Buttons
    draw_rounded_rect(draw, (100, 1480, 520, 1580), radius=24, fill=(37, 99, 235))
    draw.text((220, 1505), "Calculate", fill=(255, 255, 255), font=card_font)

    draw_rounded_rect(draw, (560, 1480, 980, 1580), radius=24, fill=(255, 255, 255), outline=(203, 213, 225), width=3)
    draw.text((720, 1505), "Reset", fill=(15, 23, 42), font=card_font)

    img.save('c:/Users/Admin/Electricitybillestimator/store_assets/screenshot_1_1080x1920.png', 'PNG')
    print("Generated screenshot_1_1080x1920.png")

# 4. Screenshot 2 (1080x1920) - Breakdown Panel Mockup
def generate_screenshot_2():
    img = Image.new('RGB', (1080, 1920), (248, 250, 252))
    draw = ImageDraw.Draw(img)

    # Header banner
    draw.rectangle((0, 0, 1080, 280), fill=(15, 23, 42))
    try:
        head_font = ImageFont.truetype("arial.ttf", 54)
        sub_font = ImageFont.truetype("arial.ttf", 30)
        card_font = ImageFont.truetype("arial.ttf", 36)
        val_font = ImageFont.truetype("arial.ttf", 40)
    except:
        head_font = ImageFont.load_default()
        sub_font = ImageFont.load_default()
        card_font = ImageFont.load_default()
        val_font = ImageFont.load_default()

    draw.text((80, 90), "Cost Breakdown & Estimates", fill=(255, 255, 255), font=head_font)
    draw.text((80, 170), "Daily, Monthly & Annual Projections", fill=(148, 163, 184), font=sub_font)

    # Phone Card Container
    draw_rounded_rect(draw, (60, 320, 1020, 1820), radius=40, fill=(255, 255, 255), outline=(226, 232, 240), width=4)

    # Itemized Breakdown List
    y = 380
    items = [
        ("Energy Consumption:", "2500 kWh"),
        ("Energy Charges:", "₹ 420.00"),
        ("Standing Charges:", "₹ 0.00"),
        ("Delivery / Network:", "₹ 0.00"),
        ("Taxes / Surcharges:", "₹ 0.00")
    ]
    for label, val in items:
        draw.text((100, y), label, fill=(100, 116, 139), font=card_font)
        draw.text((680, y), val, fill=(15, 23, 42), font=val_font)
        y += 90
        draw.line((100, y - 20, 980, y - 20), fill=(241, 245, 249), width=2)

    # Period Estimates Title
    draw.text((100, 880), "PERIOD ESTIMATES", fill=(37, 99, 235), font=sub_font)

    # 3 Small Cards
    cards = [
        ("Daily (1d)", "₹ 14.00", 100),
        ("Monthly (30d)", "₹ 420.00", 390),
        ("Annual (365d)", "₹ 5,110.00", 680)
    ]
    for title, amt, x in cards:
        is_sel = title.startswith("Monthly")
        bg_col = (239, 246, 255) if is_sel else (255, 255, 255)
        out_col = (147, 197, 253) if is_sel else (226, 232, 240)
        draw_rounded_rect(draw, (x, 940, x + 270, 1120), radius=20, fill=bg_col, outline=out_col, width=3)
        draw.text((x + 20, 970), title, fill=(30, 58, 138) if is_sel else (100, 116, 139), font=sub_font)
        draw.text((x + 20, 1030), amt, fill=(15, 23, 42), font=val_font)

    # Copy Summary Button
    draw_rounded_rect(draw, (100, 1200, 980, 1300), radius=24, fill=(255, 255, 255), outline=(203, 213, 225), width=3)
    draw.text((370, 1225), "Copy Summary", fill=(15, 23, 42), font=card_font)

    img.save('c:/Users/Admin/Electricitybillestimator/store_assets/screenshot_2_1080x1920.png', 'PNG')
    print("Generated screenshot_2_1080x1920.png")

if __name__ == '__main__':
    generate_app_icon()
    generate_feature_graphic()
    generate_screenshot_1()
    generate_screenshot_2()
