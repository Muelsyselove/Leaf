/**
 * 莱茵生命生态科 · 环境装饰组件
 * 纯装饰层，不拦截任何交互（pointer-events-none）。
 */

interface EcoBracketsProps {
  /** 括号边长 px */
  size?: number;
  /** 距容器边缘距离 px */
  inset?: number;
  /** 透明度等级（tailwind opacity 后缀之外的自定义类名） */
  className?: string;
}

/** 四角 HUD 括号 —— 贴在 relative 容器四角 */
export function EcoBrackets({ size = 16, inset = 8, className = "" }: EcoBracketsProps) {
  const base = "absolute pointer-events-none border-eco-teal/45";
  const s = { width: `${size}px`, height: `${size}px` };
  const p = `${inset}px`;
  return (
    <div aria-hidden="true" className={`absolute inset-0 pointer-events-none ${className}`}>
      <span
        className={`${base} border-t-[1.5px] border-l-[1.5px]`}
        style={{ ...s, top: p, left: p }}
      />
      <span
        className={`${base} border-t-[1.5px] border-r-[1.5px]`}
        style={{ ...s, top: p, right: p }}
      />
      <span
        className={`${base} border-b-[1.5px] border-l-[1.5px]`}
        style={{ ...s, bottom: p, left: p }}
      />
      <span
        className={`${base} border-b-[1.5px] border-r-[1.5px]`}
        style={{ ...s, bottom: p, right: p }}
      />
    </div>
  );
}

/** 莱茵六边形分子徽标 */
export function EcoHexMark({ size = 16, className = "" }: { size?: number; className?: string }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.6"
      strokeLinecap="round"
      strokeLinejoin="round"
      className={className}
      aria-hidden="true"
    >
      <path d="M12 2.5l8.25 4.75v9.5L12 21.5l-8.25-4.75v-9.5L12 2.5z" />
      <path d="M12 7.5v9" strokeWidth="1.3" />
      <path d="M8.1 9.7l7.8 4.6M15.9 9.7l-7.8 4.6" strokeWidth="1.3" />
    </svg>
  );
}

/** 主窗口环境装饰层：网格 / 角括号 / 竖排水印 / 扫描线 / 数据铭牌 */
export function EcoDecoLayer() {
  return (
    <div aria-hidden="true" className="absolute inset-0 pointer-events-none overflow-hidden z-[1]">
      {/* 菱形监测网格 */}
      <div className="eco-diamond-grid absolute inset-0 opacity-70" />

      {/* 窗口四角 HUD 括号 */}
      <EcoBrackets size={20} inset={10} />

      {/* 左下角巨型六边形轮廓 */}
      <svg
        className="absolute -left-28 -bottom-28 w-[420px] h-[420px] text-eco-teal/[0.07]"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="0.5"
      >
        <path d="M12 2.5l8.25 4.75v9.5L12 21.5l-8.25-4.75v-9.5L12 2.5z" />
        <path d="M12 6l5.5 3.2v6.3L12 18.7l-5.5-3.2V9.2L12 6z" />
      </svg>

      {/* 右侧竖排机构水印 */}
      <div className="absolute right-[6px] top-1/2 -translate-y-1/2 [writing-mode:vertical-rl] text-[9px] font-mono tracking-[0.55em] uppercase text-ink-ghost/30 select-none">
        Rhine Lab LLC — Ecological Section
      </div>

      {/* 右上角数据铭牌 */}
      <div className="absolute right-14 top-14 text-right select-none hidden lg:block">
        <div className="text-[9px] font-mono tracking-[0.3em] uppercase text-ink-ghost/35">
          Terra Surveillance Network
        </div>
        <div className="mt-1 text-[9px] font-mono tracking-[0.3em] uppercase text-eco-teal/45">
          Ecological Section · Node-003
        </div>
        <div className="mt-1.5 ml-auto h-px w-24 bg-gradient-to-l from-eco-teal/40 to-transparent" />
      </div>

      {/* 监测扫描线 */}
      <div className="eco-scanline absolute left-0 right-0 h-px bg-gradient-to-r from-transparent via-eco-teal/50 to-transparent" />
    </div>
  );
}
