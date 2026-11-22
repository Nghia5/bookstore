import { useState, useEffect, useRef } from 'react'
import { Link } from 'react-router-dom'
import { 
  MessageSquare, X, Send, Sparkles, 
  RotateCcw, ShoppingBag, Star
} from 'lucide-react'
import apiClient from '@/api/client'
import { useCartStore } from '@/stores/cartStore'
import { toast } from 'sonner'
import { cn, formatPrice } from '@/lib/utils'

interface SuggestedBook {
  id: number
  title: string
  authorNames?: string
  categoryName?: string
  originalPrice: number
  salePrice?: number
  coverImageUrl?: string
  averageRating: number
}

interface ChatMessage {
  id: string
  sender: 'user' | 'bot'
  text: string
  time: string
  suggestedBooks?: SuggestedBook[]
  quickReplies?: string[]
}

const DEFAULT_WELCOME_MESSAGE: ChatMessage = {
  id: 'welcome-1',
  sender: 'bot',
  text: 'Dạ em chào anh/chị ạ! Em là **Mai - Trợ lý tư vấn độc giả** của Bookstore Tiệm Sách Tri Thức. 📖✨\n\nEm có thể hỗ trợ anh/chị tra cứu trong hơn **1.000 đầu sách**, giải đáp **phí vận chuyển**, **mã giảm giá**, hoặc **hướng dẫn đặt hàng**. Anh/chị đang quan tâm đến tác phẩm hay chủ đề nào ạ?',
  time: new Date().toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' }),
  quickReplies: [
    '🌟 Gợi ý sách bán chạy',
    '📚 Có những thể loại nào?',
    '🚚 Phí ship & thời gian giao',
    '🎁 Các mã giảm giá hôm nay',
    '💎 Điểm tích lũy dùng sao?',
    '💻 Tìm sách về Lập trình'
  ]
}

export default function ChatWidget() {
  const [isOpen, setIsOpen] = useState(false)
  const [messages, setMessages] = useState<ChatMessage[]>(() => {
    try {
      const saved = localStorage.getItem('bookstore_chat_history')
      if (saved) return JSON.parse(saved)
    } catch {}
    return [DEFAULT_WELCOME_MESSAGE]
  })
  const [input, setInput] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [showTooltip, setShowTooltip] = useState(true)

  const messagesEndRef = useRef<HTMLDivElement>(null)
  const addItem = useCartStore((s) => s.addItem)

  // Save chat history
  useEffect(() => {
    try {
      localStorage.setItem('bookstore_chat_history', JSON.stringify(messages))
    } catch {}
  }, [messages])

  // Auto scroll to bottom
  useEffect(() => {
    if (isOpen) {
      messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
    }
  }, [messages, isOpen, isLoading])

  // Hide initial greeting tooltip after 8s
  useEffect(() => {
    const timer = setTimeout(() => setShowTooltip(false), 9000)
    return () => clearTimeout(timer)
  }, [])

  const handleSendMessage = async (textToSend?: string) => {
    const msgText = (textToSend || input).trim()
    if (!msgText || isLoading) return

    const userMsg: ChatMessage = {
      id: `user-${Date.now()}`,
      sender: 'user',
      text: msgText,
      time: new Date().toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })
    }

    setMessages((prev) => [...prev, userMsg])
    setInput('')
    setIsLoading(true)

    try {
      const historyPayload = messages.slice(-6).map((m) => ({
        role: m.sender === 'user' ? 'user' : 'assistant',
        content: m.text
      }))

      const res = await apiClient.post('/chat', {
        message: msgText,
        history: historyPayload
      })

      const botReply = res.data?.reply || 'Dạ em đã ghi nhận thông tin của anh/chị ạ!'
      const suggestedBooks = res.data?.suggestedBooks || []
      const quickReplies = res.data?.quickReplies || []

      const botMsg: ChatMessage = {
        id: `bot-${Date.now()}`,
        sender: 'bot',
        text: botReply,
        time: new Date().toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' }),
        suggestedBooks,
        quickReplies
      }

      setMessages((prev) => [...prev, botMsg])
    } catch (err) {
      const errorMsg: ChatMessage = {
        id: `bot-err-${Date.now()}`,
        sender: 'bot',
        text: 'Dạ hiện tại đường truyền kết nối của em đang bị gián đoạn đôi chút. Anh/chị có thể gọi trực tiếp Hotline **1900 6401** hoặc thử gửi lại câu hỏi nhé ạ! 🙏',
        time: new Date().toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' }),
        quickReplies: ['🚚 Phí ship bao nhiêu?', '🎁 Xem mã giảm giá', '📚 Thể loại sách']
      }
      setMessages((prev) => [...prev, errorMsg])
    } finally {
      setIsLoading(false)
    }
  }

  const handleClearChat = () => {
    if (confirm('Anh/chị có muốn xóa toàn bộ lịch sử trò chuyện không ạ?')) {
      setMessages([DEFAULT_WELCOME_MESSAGE])
      localStorage.removeItem('bookstore_chat_history')
      toast.success('Đã làm mới cuộc trò chuyện!')
    }
  }

  const handleQuickAdd = (book: SuggestedBook) => {
    addItem({
      id: book.id,
      title: book.title,
      originalPrice: book.originalPrice,
      salePrice: book.salePrice,
      coverImageUrl: book.coverImageUrl
    } as any, 1)
    toast.success(`Đã thêm "${book.title}" vào giỏ hàng!`)
  }

  // Format simple markdown into HTML elements safely
  const renderFormattedText = (content: string) => {
    const lines = content.split('\n')
    return (
      <div className="space-y-1.5 text-[13px] leading-relaxed">
        {lines.map((line, idx) => {
          if (!line.trim()) return <div key={idx} className="h-1" />

          // Parse **bold** parts
          const parts = line.split(/(\*\*.*?\*\*)/g)
          return (
            <p key={idx} className="m-0">
              {parts.map((p, pIdx) => {
                if (p.startsWith('**') && p.endsWith('**')) {
                  return <strong key={pIdx} className="font-semibold text-[#191614]">{p.slice(2, -2)}</strong>
                }
                if (p.startsWith('`') && p.endsWith('`')) {
                  return (
                    <span key={pIdx} className="px-1.5 py-0.5 mx-0.5 rounded-md bg-[#F5F3ED] border border-[#EBE7DC] font-mono text-xs font-bold text-[#B84A39]">
                      {p.slice(1, -1)}
                    </span>
                  )
                }
                return p
              })}
            </p>
          )
        })}
      </div>
    )
  }

  return (
    <div className="fixed bottom-6 right-6 z-50 flex flex-col items-end">
      
      {/* Welcome Speech Bubble Tooltip (When Chat is Closed) */}
      {!isOpen && showTooltip && (
        <div 
          onClick={() => { setIsOpen(true); setShowTooltip(false); }}
          className="mb-3 max-w-xs bg-white text-[#191614] p-3.5 rounded-2xl shadow-xl border border-[#EBE7DC] text-xs cursor-pointer animate-fade-in relative hover:border-amber-300 transition-all group"
        >
          <div className="flex items-start gap-2.5">
            <div className="w-7 h-7 rounded-full bg-amber-100 text-amber-900 flex items-center justify-center font-bold text-xs shrink-0">
              👩‍💼
            </div>
            <div>
              <p className="font-bold text-[#191614] flex items-center gap-1">
                <span>Mai • Tư vấn viên</span>
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 inline-block animate-pulse" />
              </p>
              <p className="text-[#615C56] mt-0.5">
                Dạ em chào anh/chị! Cần em gợi ý sách hay kiểm tra voucher hôm nay không ạ? 😊
              </p>
            </div>
          </div>
          {/* Arrow */}
          <div className="absolute -bottom-2 right-6 w-4 h-4 bg-white border-r border-b border-[#EBE7DC] transform rotate-45" />
        </div>
      )}

      {/* Floating Launcher Button */}
      {!isOpen && (
        <button
          onClick={() => { setIsOpen(true); setShowTooltip(false); }}
          className="group relative flex items-center gap-2.5 px-4 py-3.5 rounded-full bg-[#191614] text-white hover:bg-[#B84A39] transition-all duration-300 shadow-2xl hover:scale-105 active:scale-95"
          aria-label="Mở cửa sổ chat hỗ trợ khách hàng"
        >
          <div className="relative flex items-center justify-center">
            <MessageSquare className="w-5 h-5 text-amber-300 transition-transform group-hover:rotate-12" />
            <span className="absolute -top-1 -right-1 w-2.5 h-2.5 bg-emerald-500 border-2 border-[#191614] rounded-full" />
          </div>
          <span className="font-serif font-bold text-xs sm:text-sm tracking-wide pr-1">
            Hỏi Trợ Lý Sách
          </span>
          <Sparkles className="w-3.5 h-3.5 text-amber-400 animate-pulse" />
        </button>
      )}

      {/* Chat Window Dialog */}
      {isOpen && (
        <div className="w-[92vw] sm:w-[410px] h-[580px] max-h-[85vh] bg-[#FDFCF9] rounded-3xl shadow-2xl border border-[#EBE7DC] flex flex-col overflow-hidden animate-in fade-in slide-in-from-bottom-5 duration-200">
          
          {/* Header */}
          <div className="px-5 py-4 bg-[#191614] text-white flex items-center justify-between shrink-0 shadow-sm">
            <div className="flex items-center gap-3">
              <div className="relative">
                <div className="w-10 h-10 rounded-2xl bg-[#2D2824] border border-amber-400/30 flex items-center justify-center text-lg">
                  👩‍💼
                </div>
                <span className="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 border-2 border-[#191614] rounded-full animate-pulse" />
              </div>
              <div>
                <h3 className="font-serif font-bold text-sm tracking-wide flex items-center gap-1.5">
                  <span>Mai • Tư Vấn Viên Tiệm Sách</span>
                  <span className="text-[10px] font-sans font-bold bg-amber-500/20 text-amber-300 border border-amber-400/30 px-1.5 py-0.2 rounded-full">
                    AI 24/7
                  </span>
                </h3>
                <p className="text-[11px] text-[#A69E94] flex items-center gap-1">
                  <span>Trực tuyến • Nắm rõ 1.000+ đầu sách</span>
                </p>
              </div>
            </div>

            <div className="flex items-center gap-1 text-[#A69E94]">
              <button
                onClick={handleClearChat}
                className="p-1.5 rounded-xl hover:bg-white/10 hover:text-white transition-colors"
                title="Làm mới đoạn hội thoại"
              >
                <RotateCcw className="w-4 h-4" />
              </button>
              <button
                onClick={() => setIsOpen(false)}
                className="p-1.5 rounded-xl hover:bg-white/10 hover:text-white transition-colors"
                title="Thu nhỏ cửa sổ chat"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>

          {/* Messages Container */}
          <div className="flex-1 p-4 overflow-y-auto space-y-3.5 bg-[#FAF9F5]">
            {messages.map((m) => {
              const isBot = m.sender === 'bot'
              return (
                <div
                  key={m.id}
                  className={cn(
                    "flex flex-col gap-1 max-w-[88%]",
                    isBot ? "self-start items-start" : "self-end items-end ml-auto"
                  )}
                >
                  <div
                    className={cn(
                      "p-3.5 rounded-2xl shadow-2xs transition-all",
                      isBot
                        ? "bg-white border border-[#EBE7DC] text-[#423E3A] rounded-tl-sm"
                        : "bg-[#191614] text-white rounded-tr-sm"
                    )}
                  >
                    {isBot ? renderFormattedText(m.text) : <p className="text-[13px] leading-relaxed">{m.text}</p>}

                    {/* Suggested Book Cards Carousel / Grid */}
                    {isBot && m.suggestedBooks && m.suggestedBooks.length > 0 && (
                      <div className="mt-3.5 pt-3 border-t border-[#F5F3ED] space-y-2">
                        <span className="text-[11px] font-bold text-[#8C857B] block uppercase tracking-wider">
                          Gợi ý sách phù hợp từ kho:
                        </span>
                        <div className="space-y-2">
                          {m.suggestedBooks.map((b) => (
                            <div
                              key={b.id}
                              className="p-2.5 rounded-xl bg-[#FAF9F5] border border-[#DDD6C4] flex items-center justify-between gap-3 hover:border-[#191614] transition-all group"
                            >
                              <div className="flex items-center gap-2.5 min-w-0">
                                <img
                                  src={b.coverImageUrl || 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'}
                                  alt={b.title}
                                  className="w-9 h-12 object-cover rounded-md border border-[#DDD6C4] shrink-0"
                                  onError={(e) => {
                                    (e.target as HTMLImageElement).src = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/45/3b/fc/aa81d0a534b45706ae1eee1e344e80d9.jpg'
                                  }}
                                />
                                <div className="min-w-0">
                                  <Link
                                    to={`/books/${b.id}`}
                                    className="font-serif font-bold text-xs text-[#191614] hover:text-[#B84A39] transition-colors truncate block"
                                    title={b.title}
                                  >
                                    {b.title}
                                  </Link>
                                  <p className="text-[10px] text-[#706B65] truncate">
                                    {b.authorNames || 'Tác giả'} • <span className="text-amber-800 font-medium">{b.categoryName}</span>
                                  </p>
                                  <div className="flex items-center gap-1.5 mt-0.5">
                                    <span className="font-bold text-xs text-[#B84A39] font-sans tabular-nums">
                                      {formatPrice(b.salePrice ?? b.originalPrice)}
                                    </span>
                                    <span className="text-[10px] text-amber-700 flex items-center gap-0.5">
                                      <Star className="w-2.5 h-2.5 fill-amber-500 text-amber-500" />
                                      {b.averageRating}
                                    </span>
                                  </div>
                                </div>
                              </div>

                              <button
                                type="button"
                                onClick={() => handleQuickAdd(b)}
                                className="p-2 rounded-lg bg-[#191614] hover:bg-[#B84A39] text-white transition-colors shrink-0 shadow-2xs"
                                title="Thêm vào giỏ hàng ngay"
                              >
                                <ShoppingBag className="w-3.5 h-3.5" />
                              </button>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>

                  <span className="text-[10px] text-[#A69E94] px-1 font-mono">
                    {m.time}
                  </span>
                </div>
              )
            })}

            {/* Typing Indicator */}
            {isLoading && (
              <div className="self-start flex items-center gap-2 p-3.5 rounded-2xl bg-white border border-[#EBE7DC] text-xs text-[#706B65] shadow-2xs">
                <div className="flex items-center gap-1">
                  <span className="w-1.5 h-1.5 bg-[#B84A39] rounded-full animate-bounce" />
                  <span className="w-1.5 h-1.5 bg-[#B84A39] rounded-full animate-bounce [animation-delay:0.2s]" />
                  <span className="w-1.5 h-1.5 bg-[#B84A39] rounded-full animate-bounce [animation-delay:0.4s]" />
                </div>
                <span className="italic">Mai đang tra cứu thông tin...</span>
              </div>
            )}

            <div ref={messagesEndRef} />
          </div>

          {/* Quick Replies Carousel */}
          {messages.length > 0 && messages[messages.length - 1].quickReplies && (
            <div className="px-3 py-2 bg-white border-t border-[#F5F3ED] overflow-x-auto flex gap-1.5 scrollbar-hide shrink-0">
              {messages[messages.length - 1].quickReplies?.map((q, idx) => (
                <button
                  key={idx}
                  type="button"
                  onClick={() => handleSendMessage(q)}
                  disabled={isLoading}
                  className="px-2.5 py-1 rounded-full text-[11px] font-semibold bg-[#FAF9F5] border border-[#DDD6C4] text-[#615C56] hover:bg-[#191614] hover:text-white hover:border-[#191614] transition-all whitespace-nowrap shrink-0 shadow-2xs disabled:opacity-50"
                >
                  {q}
                </button>
              ))}
            </div>
          )}

          {/* Input Form */}
          <form
            onSubmit={(e) => {
              e.preventDefault()
              handleSendMessage()
            }}
            className="p-3 bg-white border-t border-[#EBE7DC] flex items-center gap-2 shrink-0"
          >
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              placeholder="Nhập tên sách, tác giả, phí ship, voucher..."
              disabled={isLoading}
              className="flex-1 px-3.5 py-2.5 text-xs rounded-xl border border-[#DDD6C4] bg-[#FAF9F5] focus:bg-white focus:outline-none focus:border-[#191614] text-[#191614] placeholder:text-[#A69E94]"
            />
            <button
              type="submit"
              disabled={!input.trim() || isLoading}
              className="p-2.5 rounded-xl bg-[#191614] hover:bg-[#B84A39] text-white transition-colors disabled:opacity-40 disabled:cursor-not-allowed shadow-xs shrink-0"
              title="Gửi tin nhắn"
            >
              <Send className="w-4 h-4" />
            </button>
          </form>

        </div>
      )}

    </div>
  )
}
